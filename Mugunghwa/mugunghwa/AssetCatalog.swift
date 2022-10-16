//
//  AssetCatalog.swift
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

import SwiftUI
public var docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
public var carPathLookup = ""
public var newCarPath = URL(string: "")
class AssetCatalog: Codable, Hashable, Identifiable {
    
    var carID, name, path, bundleID: String
    var kind: String        { get { return String(carID.split(separator: "-", maxSplits: 1)[0]) } }
    
    var modifiedDate: Date?
    
    var allAssetNames: [String]
    var assetNameCount: Int { get { return allAssetNames.count } }  //# of asset (# of named assets, e.g. "AppIcon" will be counted as one
    var renditions: [Rendition]
    var fileCount: Int //# of asset files (i.e. # of rendition)
    
    //Thinning Arguments
    var thinned: Bool?
    var mode: String?
    var idiom, subtype, scale, gamut, graphics, memory, target: UInt16?
    
    init() {
        self.carID = "" // UUID().uuidString
        self.name = carID
        self.path = ""
        self.bundleID = ""
        self.allAssetNames = [""]
        self.fileCount = 0
        self.renditions = [Rendition(keyAttributes: [0:0])]
    }
    
}



// MARK: - Extension: Initialization

extension AssetCatalog {
    
    convenience init(filePath: String) {
        self.init()
        
        guard
            let themeStore = CUIStructuredThemeStore(path: filePath),
            let assetStorage = themeStore.store(),
            let renditionKeys = assetStorage.allAssetKeys() as? [CUIRenditionKey]
            else { return }
        
        path = filePath
        let carFile = path.components(separatedBy: "/").reversed()[1]
        let ext = URL(fileURLWithPath: carFile).pathExtension
        let fileName = URL(fileURLWithPath: carFile).deletingPathExtension().lastPathComponent
        var kind = ""
        if path.contains("/System/Library/ControlCenter/Bundles/") && ext == "bundle" {
            kind = "CC"
        } else if path.contains("/System/Library/CoreServices/") {
            kind = "Framework"
        } else if path.contains("/System/Library/") && ext == "framework" {
            kind = "Framework"
        } else if ext == "app" {
            kind = "App"
        }
        carID = "\(kind)-\(fileName)"
        if let bundle = Bundle(path: URL(fileURLWithPath: path).deletingLastPathComponent().relativePath) {
            bundleID = bundle.bundleIdentifier ?? fileName
            if let cleanName = bundle.nameForCatalog {
                name = cleanName
            } else {
                name = fileName
            }
        }
        
        allAssetNames = assetStorage.allRenditionNames() as! [String]
        fileCount = renditionKeys.count
        
        let thinningArg = assetStorage.thinningArguments() as! NSString
        //e.g. "carutil 607.000000, thinned <mode app> <idiom 1> <subtype 2436> <subtypefallback *> <scale 3> <gamut 1> <graphics 6> <graphicsfallback (5,4,3,2,1,0)> <memory 3> <deployment- 5> <hostedIdioms (4)> <removed 4418>"
        if thinningArg.contains("thinned") || thinningArg.contains("optimized") {
            thinned = true
        }
        if let regex = try? NSRegularExpression(pattern: "(?<=<)[^>]+", options: []) {
            let results = regex.matches(in: thinningArg as String, options: [], range: NSMakeRange(0, thinningArg.length))
            let arr = results.map { thinningArg.substring(with: $0.range)}
            arr.forEach {
                let components = $0.components(separatedBy: " ")
                if components[0] == "mode" {
                    mode = components[1]
                } else if components[0] == "idiom" {
                    idiom = UInt16(components[1])
                } else if components[0] == "subtype" {
                    subtype = UInt16(components[1])
                } else if components[0] == "scale" {
                    scale = UInt16(components[1])
                } else if components[0] == "gamut" {
                    gamut = UInt16(components[1])
                } else if components[0] == "graphics" {
                    graphics = UInt16(components[1])
                } else if components[0] == "memory" {
                    memory = UInt16(components[1])
                } else if components[0] == "deployment-" {
                    target = UInt16(components[1])
                }
            }
        }
        let tokenCount = Int(assetStorage.maximumRenditionKeyTokenCount())
        var assetArray: [Rendition] = []
        for key in renditionKeys {
            if let cuiRendition = themeStore.rendition(withKey: key.keyList()) {
                let rendition = Rendition(themeRendition: cuiRendition, tokenCount: tokenCount)
                rendition.assetName = themeStore.renditionName(forKeyList: rendition.keyList) ?? rendition.name  //looking up asset name is the bottomneck
                rendition.carID = carID
                assetArray.append(rendition)
            }
        }
        
        renditions = assetArray.sorted(by: {
            ($0.assetName, $1.name, $0.appearance, $1.scale, $0.glyphWeight, $1.glyphSize) <
                ($1.assetName, $0.name, $1.appearance, $0.scale, $1.glyphWeight, $0.glyphSize)
        })
        
        //Sync Edits
        let fm = FileManager.default
        let editsFolder = docURL.appendingPathComponent(carID + "/Edits", isDirectory: true)
        if fm.fileExists(atPath: editsFolder.path) {
            for rendition in renditions {
                if fm.fileExists(atPath: editsFolder.appendingPathComponent(rendition.name).path) {
                    rendition.edited = true
                }
            }
        }
        
    }
    
}



// MARK: - Extension: Export & Recompile

extension AssetCatalog {
    
    func exportAll() {
        let fm = FileManager.default
        let carFolder = docURL.appendingPathComponent(carID, isDirectory: true)
        if !fm.fileExists(atPath: carFolder.path) {
            try? fm.createDirectory(at: carFolder, withIntermediateDirectories: true, attributes: nil)
        }
        print("exported to:")
        print(carFolder)
        let exportQueue = OperationQueue()  //exportQueue.maxConcurrentOperationCount = 4
        for rendition in renditions {
            exportQueue.addOperation {
                rendition.saveTo(url: carFolder)
            }
        }
        exportQueue.waitUntilAllOperationsAreFinished()
    }
    
    func recompile() {
        let fm = FileManager.default
        let carFolder = docURL.appendingPathComponent(carID, isDirectory: true)
        if !fm.fileExists(atPath: carFolder.path) {
            try? fm.createDirectory(at: carFolder, withIntermediateDirectories: true, attributes: nil)
        }
        let sourceCAR = carPathLookup
        let newCAR = carFolder.appendingPathComponent("Assets.car").path
        NSLog("mugunghwaconsole \(newCAR)")
        newCarPath = URL(string: newCAR)
        try? fm.removeItem(atPath: newCAR)
        try? fm.copyItem(atPath: sourceCAR, toPath: newCAR)
        
        guard
            let themeStore = CUIStructuredThemeStore(path: sourceCAR),
            let assetStorage = CUIMutableCommonAssetStorage(path: newCAR, forWriting: true)
            else { return }
        
        for rendition in renditions {
            if rendition.edited ?? false, let newImage = rendition.editedImage?.cgImage {
                if var cuiRendition = themeStore.rendition(withKey: rendition.keyList) {
                    let isInternalLink: Bool = cuiRendition.isInternalLink()
                    let linkRect: CGRect = cuiRendition._destinationFrame()
                    var carKey = themeStore.convertRenditionKey(toKeyData: rendition.keyList)
                    if isInternalLink {
                        let keyList = cuiRendition.linkingToRendition()?.keyList()
                        carKey = themeStore.convertRenditionKey(toKeyData: keyList)
                        cuiRendition = CUIThemeRendition(csiData: assetStorage.asset(forKey: carKey), forKey: keyList)
                    }
                    let unslicedSize: CGSize = cuiRendition.unslicedSize()
                    let renditionlayout = cuiRendition.type == 0 ? Int16(cuiRendition.subtype) : Int16(cuiRendition.type)
                    let generator = CSIGenerator(canvasSize: unslicedSize, sliceCount: 1, layout: renditionlayout)!
                    let wrapper = CSIBitmapWrapper(pixelWidth: UInt32(unslicedSize.width), pixelHeight: UInt32(unslicedSize.height))!
                    let context = Unmanaged<CGContext>.fromOpaque(wrapper.bitmapContext()).takeUnretainedValue()
                    if isInternalLink {
                        context.draw(cuiRendition.unslicedImage()!.takeUnretainedValue(), in: CGRect(origin: .zero, size: unslicedSize))
                        context.clear(linkRect.insetBy(dx: -2, dy: -2)) //clear the original image and the 2px broader
                        context.draw(newImage, in: linkRect)
                    } else {
                        context.draw(newImage, in: CGRect(origin: .zero, size: unslicedSize))
                    }
                    //Add Bitmap Wrapper and Set Rendition Properties
                    generator.addBitmap(wrapper)
                    generator.addSliceRect(cuiRendition._destinationFrame())
                    generator.name                          = cuiRendition.name()
                    generator.blendMode                     = cuiRendition.blendMode
                    generator.colorSpaceID                  = Int16(cuiRendition.colorSpaceID())
                    generator.exifOrientation               = cuiRendition.exifOrientation
                    generator.opacity                       = cuiRendition.opacity
                    generator.scaleFactor                   = UInt32(cuiRendition.scale())
                    generator.templateRenderingMode         = cuiRendition.templateRenderingMode()
                    generator.utiType                       = cuiRendition.utiType()
                    //generator.isRenditionFPO                = cuiRendition.isHeaderFlaggedFPO()
                    generator.isVectorBased                 = cuiRendition.isVectorBased()
                    generator.excludedFromContrastFilter    = Bool(truncating: (cuiRendition.renditionFlags()?.pointee.isExcludedFromContrastFilter ?? 0) as NSNumber)
                    //Set Asset
                    assetStorage.setAsset(generator.csiRepresentation(withCompression: true), forKey: carKey)
                }
            } else {
                //Reset other assets to avoid data occruption in the new CAR file
                if rendition.assetType != "Image Set" {
                    let keyList = rendition.keyList
                    assetStorage.setAsset(themeStore.lookupAsset(forKey: keyList), forKey: themeStore.convertRenditionKey(toKeyData: keyList))
                }
            }
        }
        assetStorage.write(toDiskAndCompact: true)
    }
    
}



// MARK: - Extension: Hashable

extension AssetCatalog {
    
    //Make AssetCatalog class Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    //Make AssetCatalog class Equatable
    public static func ==(lhs: AssetCatalog, rhs: AssetCatalog) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}

