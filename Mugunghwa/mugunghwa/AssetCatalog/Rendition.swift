//
//  Rendition.swift
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

import CoreImage
import AVKit

class Rendition: Codable, Hashable {
    // Basic Info
    let keyAttributes: [UInt16:UInt16]
    var carID, assetType, assetName, name: String
    var edited: Bool?
    var currentAssetsPath: URL?
    
    //Info for Color Rendition
    var rgbRed, rgbGreen, rgbBlue, alpha, monochromeGray: CGFloat?
    var colorSpace, subWithSystemColor: String?
    
    //Populate renditionkeytoken C struct with keyAttributes
    var keyList: [renditionkeytoken] {
        get {
            var tokens: [renditionkeytoken] = []
            keyAttributes.forEach { id, value in
                tokens.append(renditionkeytoken(identifier: id, value: value))
            }
            tokens.append(renditionkeytoken(identifier: 0, value: 0)) // plus a trailing nil?
            return tokens
        }
    }
    
    init(keyAttributes: [UInt16:UInt16]) {
        self.keyAttributes = keyAttributes
        self.carID = ""
        self.name = ""
        self.assetName = ""
        self.assetType = ""
    }
    
}



// MARK: - Extension: Initialization

extension Rendition {
    
    convenience init(themeRendition: CUIThemeRendition, tokenCount: Int = 27) {
        let keytoken = themeRendition.key()!
        var keyAttributes = [UInt16:UInt16]()
        for i in 0...tokenCount { //default to 28 token count (28 knwon rendition attributes)
            let token = keytoken.advanced(by: i).pointee
            let value = token.value
            if value > 0 {
                keyAttributes[token.identifier] = value
            }
        }
        self.init(keyAttributes: keyAttributes)
        
        let rendClass = String(describing: themeRendition.classForCoder)
        if rendClass == "_CUIThemePixelRendition" || rendClass == "_CUIInternalLinkRendition" {
            assetType = "Image"
            if element == 85 && part == 220 {
                assetType = "Icon"
            } else if element == 9 {
                assetType = "Image Set" // = Packed Asset, aka Image Atlas
            }
        } else if rendClass == "_CUIRawPixelRendition" {
            assetType = "Raw Pixel" //To distinush non PNG images?
        } else if rendClass == "_CUIThemePDFRendition" {
            assetType = "PDF"
        } else if rendClass == "_CUIThemeSVGRendition" {
            assetType = "Vector"
        } else if rendClass == "_CUIThemeColorRendition" {
            assetType = "Color"
            if let cgColor = themeRendition.cgColor()?.takeUnretainedValue() {
                if themeRendition.substituteWithSystemColor() {
                    subWithSystemColor = themeRendition.systemColorName()
                }
                colorSpace = String(((cgColor.colorSpace?.name as String?)!.dropFirst(13)))
                //colorSpace: SRGB, DisplayP3, GenericGrayGamma2_2, ExtendedSRGB, ExtendedLinearSRGB, ExtendedGray, etc
                if let components = cgColor.components {
                    if cgColor.numberOfComponents == 4 {
                        rgbRed = components[0] * 255
                        rgbGreen = components[1] * 255
                        rgbBlue = components[2] * 255
                        alpha = components[3]
                    } else if cgColor.numberOfComponents == 2 {
                        monochromeGray = components[0]
                        alpha = components[1]
                    }
                }
            }
        } else if rendClass == "_CUIRawDataRendition" {
            assetType = "Raw Data"
        } else if rendClass == "_CUIThemeMultisizeImageSetRendition" {
            assetType = "Multisize Image Set"  //App Icon Image Set? (No images, just an array of image size classes corresponding to CUIInternalLinkRendition?
        } else if rendClass == "_CUINameContentRendition" {
            assetType = "Content"
        } else if rendClass == "CUIThemeGradientRendition" {
            assetType = "Gradient"
        } else if rendClass == "CUIThemeEffectRendition" {
            assetType = "Effect"
        }
        
        name = themeRendition.name()
        if assetType == "Image" {
            if name.hasSuffix(".png") || name.hasSuffix(".pdf") || name.hasSuffix(".svg") {
                var nameString = name.dropLast(4)
                if nameString.lowercased().hasSuffix("@2x") || nameString.lowercased().hasSuffix("@3x") {
                    nameString = nameString.dropLast(3)
                }
                if gamut > 0 {
                    nameString += "_\(Gamut)"
                }
                if name.hasSuffix(".svg") {
                    nameString += "_\(GlyphWeight)-\(GlyphSize.first!)"
                    if dim2 > 0 {
                        nameString += "_Part-\(dim2)"
                    }
                }
                if scale > 1 {
                    name = nameString + "@\(String(scale))x.png"
                } else {
                    name = nameString + ".png"
                }
            }
        } else if assetType == "Icon" && scale > 1 {
            name = name.dropLast(4) + "@\(String(scale))x.png"
        } else if assetType == "Vector" {
            var nameString = name
            if name.hasSuffix(".svg") {
                nameString = String(nameString.dropLast(4))
            }
            name = nameString + "_\(GlyphWeight)-\(GlyphSize.first!).svg"
        } else if assetType == "Image Set" {
            var nameString = name
            if dim1 > 0 {
                nameString += "_Dim-\(dim1)"
            }
            if appearance != 0 {
                nameString += "_\(Appearance)" //"_\(Attributes.Appearances[any: appearance])"
            }
            name = nameString + ".png"
        } else if assetType == "Color" {
            var nameString = ""
            if monochromeGray != nil {
                nameString = String(format:"%.0f%%", monochromeGray! * 100)
            } else {
                nameString = colorHEX
            }
            if (alpha ?? 1) < 1 {
                nameString += String(format:", Opacity: %.0f%%", alpha! * 100)
            }
            nameString += " (" + (colorSpace ?? "")
            if appearance != 0 {
                nameString += " - " + Appearance
            }
            nameString += ")"
            name = nameString
        }
        
    }
    
}



// MARK: - Extension: Image Getters

extension Rendition {
    
    var image: UIImage? {
        get {
            print("printing car id and car path lookup")
            if let themeStore = CUIStructuredThemeStore(path: String(describing: currentAssetsPath!)) {
                if let cuiRendition = themeStore.rendition(withKey: keyList) {
                    if assetType == "Vector" {
                        if let catalog = try? CUICatalog(url: currentAssetsPath!),
                            let namedVector = CUINamedVectorGlyph(name: assetName, using: CUIRenditionKey(keyList: keyList), fromTheme: catalog.storageRef), //can we get storeref via other means?
                            let svgData = cuiRendition.value(forKey: "rawData") as? Data,
                            let svgString = String(data: svgData, encoding: .utf8),
                            let regexWidth = svgString.range(of: #"(?<=width=")[^"]+"#, options: .regularExpression),
                            let regexHeight = svgString.range(of: #"(?<=height=")[^"]+"#, options: .regularExpression),
                            let svgWidth = Double(svgString[regexWidth]),
                            let svgHeight = Double(svgString[regexHeight]) {
                            let svgSize = CGSize(width: svgWidth, height: svgHeight)
                            if let svgCGImage = namedVector.rasterizeImage(usingScaleFactor: Double(UIScreen.main.scale), forTargetSize: svgSize)?.takeUnretainedValue() {
                                UIGraphicsBeginImageContextWithOptions(svgSize, false, 0)
                                UIImage(cgImage: svgCGImage).draw(in: CGRect(origin: .zero, size: svgSize))
                                let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                                UIGraphicsEndImageContext()
                                return outputImg
                            }
                        }
                    } else if assetType == "Color" {
                        if let renditionColor = cuiRendition.cgColor()?.takeUnretainedValue() {
                            let rect = CGRect(x: 0, y: 0, width: 250, height: 250) //Details view image size
                            let length = rect.size.width
                            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
                            let context = UIGraphicsGetCurrentContext()!
                            UIBezierPath(roundedRect: rect, cornerRadius: 45).addClip()
                            if renditionColor.alpha < 1 {
                                context.setFillColor(gray: 1, alpha: 1)
                                context.fill(rect)
                                context.beginPath()
                                context.move(to: .zero)
                                context.addLine(to: CGPoint(x: length, y: 0))
                                context.addLine(to: CGPoint(x: 0, y: length))
                                context.closePath()
                                context.setFillColor(gray: 0, alpha: 1)
                                context.fillPath()
                            }
                            context.setFillColor(renditionColor)
                            context.fill(rect)
                            let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            return outputImg
                        }
                    } else if assetType == "PDF" {
                        if let sourceImg = cuiRendition.createImageFromPDFRendition(withScale: Double(UIScreen.main.scale))?.takeUnretainedValue() {
                            let originalSize = CGSize(width: sourceImg.width, height: sourceImg.height)
                            UIGraphicsBeginImageContextWithOptions(originalSize, false, 0)
                            UIImage(cgImage: sourceImg).draw(in: CGRect(origin: .zero, size: originalSize))
                            let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            return outputImg
                        }
                    } else { //could fail in this catach all for none image types
                        //return UIImage(cgImage: cuiRendition.unslicedImage().takeUnretainedValue())  // direct convertion to UIImage seems to cause color space / pixcel format error
                        let sourceImg = cuiRendition.unslicedImage().takeUnretainedValue()
                        let originalSize = CGSize(width: sourceImg.width, height: sourceImg.height) // The size of the CGImage retreived is at 1x (i.e. width and height are pixel, not point)
                        UIGraphicsBeginImageContextWithOptions(originalSize, false, 1) // We don't need to scale the CGImage as we are drawing at the pixel size
                        UIImage(cgImage: sourceImg).draw(in: CGRect(origin: .zero, size: originalSize)) //UIGraphicsGetCurrentContext()?.draw(sourceImg, in: CGRect(origin: .zero, size: size))
                        let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        return outputImg
                    }
                }
                
            }
            return nil
        }
    }
    
    var previewImage: UIImage? {
        get {
            if let themeStore = CUIStructuredThemeStore(path: String(describing: currentAssetsPath!)) {
                if let cuiRendition = themeStore.rendition(withKey: keyList) {
                    let rect = CGRect(x: 0, y: 0, width: 72, height: 72) //preview grid size
                    if assetType == "Vector" {
                        if let catalog = try? CUICatalog(url: currentAssetsPath!),
                            let namedVector = CUINamedVectorGlyph(name: assetName, using: CUIRenditionKey(keyList: keyList), fromTheme: catalog.storageRef), //can we get storeref via other means?
                            let svgData = cuiRendition.value(forKey: "rawData") as? Data,
                            let svgString = String(data: svgData, encoding: .utf8),
                            let regexWidth = svgString.range(of: #"(?<=width=")[^"]+"#, options: .regularExpression),
                            let regexHeight = svgString.range(of: #"(?<=height=")[^"]+"#, options: .regularExpression),
                            let svgWidth = Double(svgString[regexWidth]),
                            let svgHeight = Double(svgString[regexHeight]) {
                            let svgSize = CGSize(width: svgWidth, height: svgHeight)
                            let svgSizeScaled = AVMakeRect(aspectRatio: svgSize, insideRect: rect).size
                            if let svgCGImage = namedVector.rasterizeImage(usingScaleFactor: Double(UIScreen.main.scale), forTargetSize: svgSizeScaled)?.takeUnretainedValue() {
                                UIGraphicsBeginImageContextWithOptions(svgSize, false, 0)
                                UIImage(cgImage: svgCGImage).draw(in: CGRect(origin: .zero, size: svgSize))
                                let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                                UIGraphicsEndImageContext()
                                return outputImg
                            }
                        }
                    } else if assetType == "Color" {
                        if let renditionColor = cuiRendition.cgColor()?.takeUnretainedValue() {
                            let length = rect.size.width
                            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
                            let context = UIGraphicsGetCurrentContext()!
                            UIBezierPath(roundedRect: rect, cornerRadius: 15).addClip()
                            if renditionColor.alpha < 1 {
                                context.setFillColor(gray: 1, alpha: 1)
                                context.fill(rect)
                                context.beginPath()
                                context.move(to: .zero)
                                context.addLine(to: CGPoint(x: length, y: 0))
                                context.addLine(to: CGPoint(x: 0, y: length))
                                context.closePath()
                                context.setFillColor(gray: 0, alpha: 1)
                                context.fillPath()
                            }
                            context.setFillColor(renditionColor)
                            context.fill(rect)
                            let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            return outputImg
                        }
                    } else if assetType == "PDF" {
                        if let sourceImg = cuiRendition.createImageFromPDFRendition(withScale: Double(UIScreen.main.scale))?.takeUnretainedValue() {
                            let originalSize = CGSize(width: sourceImg.width, height: sourceImg.height)
                            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
                            UIImage(cgImage: sourceImg).draw(in: AVMakeRect(aspectRatio: originalSize, insideRect: rect))
                            let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            return outputImg
                        }
                    } else { //could fail in this catach all for none image types
                        let sourceImg = cuiRendition.unslicedImage().takeUnretainedValue()
                        let originalSize = CGSize(width: sourceImg.width, height: sourceImg.height)
                        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
                        UIImage(cgImage: sourceImg).draw(in: AVMakeRect(aspectRatio: originalSize, insideRect: rect))
                        let outputImg = UIGraphicsGetImageFromCurrentImageContext()
                        UIGraphicsEndImageContext()
                        return outputImg
                    }
                }
            }
            return nil
        }
    }
    
    var editedImage: UIImage? {
        get {
            if edited ?? false {
                let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(carID + "/Edits/" + name)
                print("yes edited")
                print(fileURL)
                return UIImage(contentsOfFile: fileURL.path)
            }
            return nil
        }
    }
    
}



// MARK: - Extension: Export & Edit Asset

extension Rendition {
    
    func saveTo(url: URL) {
        let fileURL = url.appendingPathComponent(name)
        if (assetType == "Image" || assetType == "Icon" || assetType == "Image Set") {
            if let pngData = image?.pngData() {
                try? pngData.write(to: fileURL)
            }
        } else if assetType == "Raw Pixel" {
            if (name.hasSuffix(".jpg") || name.hasSuffix(".jpeg")) {
                if let jpegData = image?.jpegData(compressionQuality: 1) {
                    try? jpegData.write(to: fileURL)
                }
            } else {
                if let pngData = image?.pngData() {
                    try? pngData.write(to: fileURL)
                }
            }
        } else if (assetType == "PDF" || assetType == "Vector" || assetType == "Raw Data") {
            if let themeStore = CUIStructuredThemeStore(path: Bundle.main.path(forResource: "example", ofType: "car")!) {
                if let cuiRendition = themeStore.rendition(withKey: keyList) {
                    if assetType == "PDF" {
                        let data = cuiRendition.srcData
                        try? data?.write(to: fileURL)
                    } else if assetType == "Vector" {
                        let data = cuiRendition.value(forKey: "rawData") as? Data
                        try? data?.write(to: fileURL)
                    } else if assetType == "Raw Data" {
                        let data = cuiRendition.value(forKey: "data") as? Data
                        try? data?.write(to: fileURL)
                    }
                }
            }
        }
    }
    
    //Edited here
    func saveEditedImage(_ uiImage: UIImage) {
        let fm = FileManager.default
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        let editsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(carID + "/Edits", isDirectory: true)
        print("printing edits folder")
        print(editsFolder)
        if !fm.fileExists(atPath: editsFolder.path) {
            try? fm.createDirectory(at: editsFolder, withIntermediateDirectories: true, attributes: nil)
        }
        let fileURL = editsFolder.appendingPathComponent(name)
        print("will be saved as:")
        print(fileURL)
        var data: Data?
        if (name.hasSuffix(".jpg") || name.hasSuffix(".jpeg")) {
            data = uiImage.jpegData(compressionQuality: 1)
        } else {
            data = uiImage.pngData()
        }
        do {
            try! data?.write(to: fileURL)
        } catch {
            print(error)
        }
        edited = true
    }
    
    func removeEditedImage() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(carID + "/Edits/" + name)
        try? FileManager.default.removeItem(at: fileURL)
        edited = false
    }
    
}



// MARK: - Extension: Display Name & File Extension

extension Rendition {
    //Note: Rendition name (i.e. 'name') and Asset name (i.e. 'assetName') are not unique
    //Further, the file extension in the rendition name may not be the correct file extension of the rendition's media type
    //Hence, we need to derive a distinct and correct file name for export
    
    var displayName: String {
        get {
            var prettyName = name
            if prettyName.hasSuffix(".png") || prettyName.hasSuffix(".pdf") ||  prettyName.hasSuffix(".svg") || prettyName.hasSuffix(".jpg") {
                prettyName = String(prettyName.dropLast(4))
            }
            if prettyName.hasPrefix("ZZZZPackedAsset") {
                prettyName = String(prettyName.dropFirst(16))
            }
            return prettyName
        }
    }
    
    var fileExtension: String {
        get {
            return URL(fileURLWithPath: name).pathExtension
        }
    }
    
    var colorHEX: String { get { return String(format:"#%02X%02X%02X", Int(rgbRed ?? 0), Int(rgbGreen ?? 0), Int(rgbBlue ?? 0)) } }
    
    var isImageType: Bool { get { (assetType == "Image" || assetType == "Icon" || assetType == "Image Set" || assetType == "Raw Pixel" ) ? true : false } }
    
}



// MARK: - Extension: Attributes Getters & Parser

extension Rendition {
    
    //Attributes Getters                                                        // Reference to CUIRenditionKey Properties / KeyFormat ID
                                                                                // renditionkeytoken_id: 0  (= attribute_ThemeLook??)
    var element: UInt16             { get { return keyAttributes[1] ?? 0 } }    // renditionkeytoken_id: 1  = themeElement
    var part: UInt16                { get { return keyAttributes[2] ?? 0 } }    // renditionkeytoken_id: 2  = themePart
    var size: UInt16                { get { return keyAttributes[3] ?? 0 } }    // renditionkeytoken_id: 3  = themeSize
    var direction: UInt16           { get { return keyAttributes[4] ?? 0 } }    // renditionkeytoken_id: 4  = themeDirection
                                                                                // renditionkeytoken_id: 5  (= attribute_placeholder??)
    var value: UInt16               { get { return keyAttributes[6] ?? 0 } }    // renditionkeytoken_id: 6  = themeValue
    var appearance: UInt16          { get { return keyAttributes[7] ?? 0 } }    // renditionkeytoken_id: 7  = themeAppearance
    var dim1: UInt16                { get { return keyAttributes[8] ?? 0 } }    // renditionkeytoken_id: 8  = themeDimension1
    var dim2: UInt16                { get { return keyAttributes[9] ?? 0 } }    // renditionkeytoken_id: 9  = themeDimension2
    var state: UInt16               { get { return keyAttributes[10] ?? 0 } }   // renditionkeytoken_id: 10 = themeState
    var layer: UInt16               { get { return keyAttributes[11] ?? 0 } }   // renditionkeytoken_id: 11 = themeLayer
    var scale: UInt16               { get { return keyAttributes[12] ?? 0 } }   // renditionkeytoken_id: 12 = themeScale
    var localization: UInt16        { get { return keyAttributes[13] ?? 0 } }   // renditionkeytoken_id: 13 = themeLocalization
    var presentationState: UInt16   { get { return keyAttributes[14] ?? 0 } }   // renditionkeytoken_id: 14 = themePresentationState
    var idiom: UInt16               { get { return keyAttributes[15] ?? 0 } }   // renditionkeytoken_id: 15 = themeIdiom
    var deviceSubtype: UInt16       { get { return keyAttributes[16] ?? 0 } }   // renditionkeytoken_id: 16 = themeSubtype (Note: Device subtype =/= Rendition subtype)
    var identifier: UInt16          { get { return keyAttributes[17] ?? 0 } }   // renditionkeytoken_id: 17 = themeIdentifier
    var previousValue: UInt16       { get { return keyAttributes[18] ?? 0 } }   // renditionkeytoken_id: 18 = themePreviousValue
    var previousState: UInt16       { get { return keyAttributes[19] ?? 0 } }   // renditionkeytoken_id: 19 = themePreviousState
    var sizeHorizontal: UInt16      { get { return keyAttributes[20] ?? 0 } }   // renditionkeytoken_id: 20 = themeSizeClassHorizontal
    var sizeVertical: UInt16        { get { return keyAttributes[21] ?? 0 } }   // renditionkeytoken_id: 21 = themeSizeClassVertical
    var memory: UInt16              { get { return keyAttributes[22] ?? 0 } }   // renditionkeytoken_id: 22 = themeMemoryClass "Memory Level Class"
    var graphics: UInt16            { get { return keyAttributes[23] ?? 0 } }   // renditionkeytoken_id: 23 = themeGraphicsClass "raphics Feature Set Class"
    var gamut: UInt16               { get { return keyAttributes[24] ?? 0 } }   // renditionkeytoken_id: 24 = themeDisplayGamut
    var target: UInt16              { get { return keyAttributes[25] ?? 0 } }   // renditionkeytoken_id: 25 = themeDeploymentTarget
    var glyphWeight: UInt16         { get { return keyAttributes[26] ?? 0 } }   // renditionkeytoken_id: 26 = themeGlyphWeight
    var glyphSize: UInt16           { get { return keyAttributes[27] ?? 0 } }   // renditionkeytoken_id: 27 = themeGlyphSize
    
    
    //Attributes Parser
    
    var Element: String             { get { return Attributes.Element[Int(element), default: "n.a."] } }
    var Part: String                { get { return Attributes.Part[Int(part), default: "n.a."] } }
    var Size: String                { get { return Attributes.Size[Int(size), default: "n.a."] } }
    var Direction: String           { get { return Attributes.Direction[Int(direction), default: "n.a."] } }
    var Value: String               { get { return Attributes.Value[Int(value), default: "n.a."] } }
    var Appearance: String          { get { return Attributes.Appearance[Int(appearance), default: "n.a."] } }
    var State: String               { get { return Attributes.State[Int(state), default: "n.a."] } }
    var Layer: String               { get { return Attributes.Layer[Int(layer), default: "n.a."] } }
    var Scale: String               { get { return Attributes.Scale[Int(scale), default: "n.a."] } }
    var Localization: String        { get { return Attributes.Localization[Int(localization), default: "n.a."] } }
    var PresentationState: String   { get { return Attributes.PresentationState[Int(presentationState), default: "n.a."] } }
    var Device: String              { get { return Attributes.Device[Int(idiom), default: "n.a."] } }
    var PreviousValue: String       { get { return Attributes.Value[Int(previousValue), default: "n.a."] } }
    var PreviousState: String       { get { return Attributes.State[Int(previousState), default: "n.a."] } }
    var SizeClassH: String          { get { return Attributes.SizeClass[Int(sizeHorizontal), default: "n.a."] } }
    var SizeClassV: String          { get { return Attributes.SizeClass[Int(sizeVertical), default: "n.a."] } }
    var Memory: String              { get { return Attributes.Memory[Int(memory), default: "n.a."] } }
    var Graphics: String            { get { return Attributes.Graphics[Int(graphics), default: "n.a."] } }
    var Gamut: String               { get { return Attributes.Gamut[Int(gamut), default: "n.a."] } }
    var GlyphWeight: String         { get { return Attributes.GlyphWeight[Int(glyphWeight), default: "n.a."] } }
    var GlyphSize: String           { get { return Attributes.GlyphSize[Int(glyphSize), default: "n.a."] } }

    
    private var attributeDescription: String {
        get { return "Asset Attributes = Device: \(Device), Appearance: \(Appearance), Scale: \(Scale), Gamut: \(Gamut), Direction: \(Direction), HorizontalClass: \(SizeClassH), VerticalClass: \(SizeClassV), Memory: \(Memory), Graphics: \(Graphics), Localization: \(Localization), Elements: \(Element), Parts: \(Part), ID: \(identifier)" }
    }
    
}



// MARK: - Extension: Hashable

extension Rendition {
    
    //Make Rendition class Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    //Make Rendition class Equatable
    public static func ==(lhs: Rendition, rhs: Rendition) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}

