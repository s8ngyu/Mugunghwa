//
//  ThemeManager.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 08/11/2022.
//

import Foundation
import SwiftUI

class Theme: Identifiable {
    let id: UUID
    var name: String
    var path: URL?
    var count: Int
    
    init() {
        self.id = UUID()
        self.name = ""
        self.path = nil
        self.count = 0
    }
}

extension Theme {
    convenience init(withPath: URL) {
        self.init()
        
        name = withPath.lastPathComponent
        path = withPath
        count = getList(atPath: path!).count
    }
    
    func getIcon(bundleIdentifier: String) -> UIImage? {
        let helper = ObjcHelper.init()
        let fileManager = FileManager.default
        
        var data: Data?
        
        if fileManager.fileExists(atPath: path!.appendingPathComponent("\(bundleIdentifier)-large.png").path) {
            data = helper.dataForImage(at: path!.appendingPathComponent("\(bundleIdentifier)-large.png").path)
        } else if fileManager.fileExists(atPath: path!.appendingPathComponent("\(bundleIdentifier).png").path) {
            data = helper.dataForImage(at: path!.appendingPathComponent("\(bundleIdentifier).png").path)
        } else if fileManager.fileExists(atPath: path!.appendingPathComponent("\(bundleIdentifier)@3x.png").path) {
            data = helper.dataForImage(at: path!.appendingPathComponent("\(bundleIdentifier)@3x.png").path)
        } else if fileManager.fileExists(atPath: path!.appendingPathComponent("\(bundleIdentifier)@2x.png").path) {
            data = helper.dataForImage(at: path!.appendingPathComponent("\(bundleIdentifier)@2x.png").path)
        } else {
            return nil
        }
        
        let image = UIImage(data: data!)
        
        return image
    }
}

class Apps: Identifiable {
    let id: UUID
    var bundlePath: URL?
    var bundleIdentifier: String
    var localisedName: String
    var isUpdating: Bool
    var isSystem: Bool
    var isTrollStoreInstalled: Bool
    var themable: Bool
    var legacyThemable: Bool
    var icons: [String]
    
    init() {
        self.id = UUID()
        self.bundlePath = nil
        self.bundleIdentifier = ""
        self.localisedName = ""
        self.isUpdating = false
        self.isSystem = false
        self.isTrollStoreInstalled = false
        self.themable = false
        self.legacyThemable = false
        self.icons = [String]()
    }
}

extension Apps {
    convenience init(bundle: LSApplicationProxy) {
        self.init()
        
        let fileManager = FileManager.default
        let helper = ObjcHelper.init()
        
        bundlePath = bundle.bundleURL
        bundleIdentifier = bundle.applicationIdentifier
        localisedName = bundle.localizedName()
        
        isSystem = bundlePath!.path.contains("Applications")
        isTrollStoreInstalled = fileManager.fileExists(atPath: bundlePath!.deletingLastPathComponent().appendingPathComponent("_TrollStore").path)
        
        if !isSystem {
            isUpdating = fileManager.fileExists(atPath: bundlePath!.deletingLastPathComponent().appendingPathComponent("com.apple.mobileinstallation.placeholder").path)
        }
        themable = fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("Assets.car").path)
        if isUpdating {
            themable = false
        }
        
        if !isSystem && themable {
            // create bak.assets if it doesn't exist
            if (fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("Assets.car").path) && !fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("bak.car").path)) {
                helper.copyWithRoot(at: bundlePath!.appendingPathComponent("Assets.car").path, to: bundlePath!.appendingPathComponent("bak.car").path)
            }
        }
        if (isTrollStoreInstalled && !themable) {
            let helper = ObjcHelper.init()
            let infoPlist = NSDictionary(contentsOfFile: bundlePath!.appendingPathComponent("Info.plist").path)!
            
            icons = getIcons(dictionary: infoPlist)
            
            if icons.count != 0 {
                // create backups if backup doesn't exist
                for icon in icons {
                    if (fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("\(icon).png").path) && !fileManager.fileExists(atPath: bundlePath!.appendingPathComponent("\(icon)bak.png").path)) {
                        helper.copyWithRoot(at: bundlePath!.appendingPathComponent("\(icon).png").path, to: bundlePath!.appendingPathComponent("\(icon)bak.png").path)
                    }
                }
                legacyThemable = true
            }
        }
    }
}

func getIcons(dictionary: NSDictionary) -> [String] {
    var tmp = [String]()
    for key in dictionary.allKeys {
        if String(describing: key) == "CFBundleIconFiles" {
            tmp += dictionary[key] as? [String] ?? [String]()
        } else {
            tmp += getIcons(dictionary: dictionary[key] as? NSDictionary ?? [:])
        }
    }
    
    for (index, icon) in tmp.enumerated() {
        if icon.contains(".png") {
            tmp[index] = icon.replacingOccurrences(of: ".png", with: "")
        }
    }
    
    return Array(Set(tmp))
}

func getSelectedTheme() -> Theme? {
    checkAndCreateBackupFolder()
    let prefs = MGPreferences.init(identifier: "me.soongyu.mugunghwa")
    let tmp = prefs.dictionary["selectedTheme"]
    if (tmp != nil) {
        let path = URL(fileURLWithPath: "/private/var/mobile/mugunghwa/Themes").appendingPathComponent(tmp as! String)
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path.path) {
            return Theme(withPath: path)
        }
    }
    
    return nil
}

func getAppsList() -> [Apps] {
    let apps = LSApplicationWorkspace.default().allApplications() ?? []
    var tmp = [Apps]()
    for e in apps {
        let app = Apps.init(bundle: e)
        if (app.themable || app.legacyThemable) && (app.bundleIdentifier != "com.apple.mobiletimer") {
            tmp.append(app)
        }
    }
    
    return tmp
}

func applyThemev2(selection: Theme?) {
    let apps = getAppsList()
    let helper = ObjcHelper.init()
    let group = DispatchGroup()
    let fileManager = FileManager.default
    let webClipPlistURL = Bundle.main.url(forResource: "webclip", withExtension: "plist")
    
    if !fileManager.fileExists(atPath: "/private/var/mobile/mugunghwa/SystemAppsTheme") {
        try? fileManager.createDirectory(atPath: "/private/var/mobile/mugunghwa/SystemAppsTheme", withIntermediateDirectories: true)
    }
    
    if !fileManager.fileExists(atPath: "/private/var/mobile/mugunghwa/tmp") {
        try? fileManager.createDirectory(atPath: "/private/var/mobile/mugunghwa/tmp", withIntermediateDirectories: true)
    }
    
    if (selection != nil) {
        for app in apps {
            if !app.isSystem {
                group.enter()
                // theme user apps
                DispatchQueue.global(qos: .userInitiated).async {
                    //apply default before changing themes
                    if app.themable {
                        if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("bak.car").path) {
                            helper.copyWithRoot(at: app.bundlePath!.appendingPathComponent("bak.car").path, to: app.bundlePath!.appendingPathComponent("Assets.car").path)
                        }
                    }
                    if app.legacyThemable {
                        for icon in app.icons {
                            if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("\(icon)bak.png").path) {
                                helper.copyWithRoot(at: app.bundlePath!.appendingPathComponent("\(icon)bak.png").path, to: app.bundlePath!.appendingPathComponent("\(icon).png").path)
                            }
                        }
                    }

                    //check if theme for this app exists
                    let themeImage = selection!.getIcon(bundleIdentifier: app.bundleIdentifier)
                    if (themeImage != nil) {
                        if app.themable {
                            //modify assets.car
                            let catalog = AssetCatalog(filePath: app.bundlePath!.appendingPathComponent("Assets.car").path)
                            
                            for rendition in catalog.renditions {
                                if (rendition.assetType == "Icon") {
                                    if (rendition.image != nil) {
                                        rendition.saveEditedImage(themeImage!.imageResized(to: rendition.image!.size))
                                    } else {
                                        rendition.saveEditedImage(themeImage!)
                                    }
                                }
                            }
                            
                            // recompile
                            catalog.recompile()
                            // apply
                            helper.moveWithRoot(at: fileManager.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(catalog.carID).appendingPathComponent("Assets.car").path, to: app.bundlePath!.appendingPathComponent("Assets.car").path)
                        }
                        if app.legacyThemable {
                            // modify images
                            for icon in app.icons {
                                let image = helper.getImageFromData(app.bundlePath!.appendingPathComponent("\(icon).png").path)
                                var resized = themeImage!.imageResized(to: CGSize(width: image.size.width, height: image.size.height))
                                resized = resized.imageResized(to: CGSize(width: resized.size.width/resized.scale, height: resized.size.height/resized.scale))
                                helper.save(resized, atPath: "/private/var/mobile/mugunghwa/tmp/\(app.bundleIdentifier)-\(icon).png")
                                helper.copyWithRoot(at: "/private/var/mobile/mugunghwa/tmp/\(app.bundleIdentifier)-\(icon).png", to: app.bundlePath!.appendingPathComponent("\(icon).png").path)
                            }
                        }
                    }
                    group.leave()
                }
            } else {
                // theme system apps
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    let themeImage = selection!.getIcon(bundleIdentifier: app.bundleIdentifier)
                    if (themeImage != nil) {
                        let webClipURL = URL(fileURLWithPath: "/private/var/mobile/Library/WebClips/Mugunghwa-\(app.bundleIdentifier).webclip")
                        let iconURL = URL(fileURLWithPath: "/private/var/mobile/mugunghwa/SystemAppsTheme/\(app.bundleIdentifier).png")
                        // save image to SystemAppsTheme
                        helper.save(themeImage!, atPath: iconURL.path)
                        // check if webclip for this app exists
                        if !fileManager.fileExists(atPath: webClipURL.path) {
                            // create webclip
                            try? fileManager.createDirectory(atPath: webClipURL.path, withIntermediateDirectories: true)
                            try? fileManager.createSymbolicLink(atPath: webClipURL.appendingPathComponent("icon.png").path, withDestinationPath: iconURL.path)
                            var webClipInfo = NSMutableDictionary(contentsOfFile: webClipPlistURL!.path)!
                            webClipInfo.setValue(app.bundleIdentifier, forKey: "ApplicationBundleIdentifier")
                            webClipInfo.setValue(app.localisedName, forKey: "Title")
                            webClipInfo.write(toFile: webClipURL.appendingPathComponent("Info.plist").path, atomically: true)
                        }
                    }
                    group.leave()
                }
            }
        }
    }
    
    group.notify(queue: .main) {
        UIApplication.shared.plainAlert(title: "Done", message: "Successfully applied themes. Please rebuild icon cache using TrollStore app.")
    }
}

func restoreTheme() {
    let apps = getAppsList()
    let helper = ObjcHelper.init()
    let group = DispatchGroup()
    let fileManager = FileManager.default
    
    for app in apps {
        if !app.isSystem {
            group.enter()
            // user apps
            DispatchQueue.global(qos: .userInitiated).async {
                if app.themable {
                    if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("bak.car").path) {
                        helper.moveWithRoot(at: app.bundlePath!.appendingPathComponent("bak.car").path, to: app.bundlePath!.appendingPathComponent("Assets.car").path)
                    }
                }
                if app.legacyThemable {
                    for icon in app.icons {
                        if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("\(icon)bak.png").path) {
                            helper.copyWithRoot(at: app.bundlePath!.appendingPathComponent("\(icon)bak.png").path, to: app.bundlePath!.appendingPathComponent("\(icon).png").path)
                        }
                    }
                }
                group.leave()
            }
        } else {
            group.enter()
            // system apps
            DispatchQueue.global(qos: .userInitiated).async {
                let webClipURL = URL(fileURLWithPath: "/private/var/mobile/Library/WebClips/Mugunghwa-\(app.bundleIdentifier).webclip")
                if fileManager.fileExists(atPath: webClipURL.path) {
                    try? fileManager.removeItem(atPath: webClipURL.path)
                }
                group.leave()
            }
        }
    }
    
    group.notify(queue: .main) {
        UIApplication.shared.plainAlert(title: "Done", message: "Successfully restored to default. Please rebuild icon cache using TrollStore app.")
    }
}
