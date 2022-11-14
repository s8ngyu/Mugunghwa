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
    var themable: Bool
    
    init() {
        self.id = UUID()
        self.bundlePath = nil
        self.bundleIdentifier = ""
        self.localisedName = ""
        self.isUpdating = false
        self.isSystem = false
        self.themable = false
    }
}

extension Apps {
    convenience init(bundle: LSApplicationProxy) {
        self.init()
        
        bundlePath = bundle.bundleURL
        bundleIdentifier = bundle.applicationIdentifier
        localisedName = bundle.localizedName()
        
        isSystem = bundlePath!.path.contains("Applications")
        
        let fileManager = FileManager.default
        let helper = ObjcHelper.init()
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
    }
}

func getSelectedTheme() -> Theme? {
    checkAndCreateBackupFolder()
    let prefs = MGPreferences.init(identifier: "me.soongyu.mugunghwa")
    let tmp = prefs.dictionary["selectedTheme"]
    if (tmp != nil) {
        let path = URL(string: "/private/var/mobile/mugunghwa/Themes")!.appendingPathComponent(tmp as! String)
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
        if app.themable && (app.bundleIdentifier != "com.apple.mobiletimer") {
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
    
    if (selection != nil) {
        for app in apps {
            if !app.isSystem {
                group.enter()
                // theme user apps
                DispatchQueue.global(qos: .userInitiated).async {
                    //apply default before changing themes
                    if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("bak.car").path) {
                        helper.moveWithRoot(at: app.bundlePath!.appendingPathComponent("bak.car").path, to: app.bundlePath!.appendingPathComponent("Assets.car").path)
                    }
                    //check if theme for this app exists
                    let themeImage = selection!.getIcon(bundleIdentifier: app.bundleIdentifier)
                    if (themeImage != nil) {
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
                    group.leave()
                }
            } else {
                // theme system apps
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    let themeImage = selection!.getIcon(bundleIdentifier: app.bundleIdentifier)
                    if (themeImage != nil) {
                        let webClipURL = URL(string: "/private/var/mobile/Library/WebClips/Mugunghwa-\(app.bundleIdentifier).webclip")!
                        let iconURL = URL(string: "/private/var/mobile/mugunghwa/SystemAppsTheme/\(app.bundleIdentifier).png")!
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
                if fileManager.fileExists(atPath: app.bundlePath!.appendingPathComponent("bak.car").path) {
                    helper.moveWithRoot(at: app.bundlePath!.appendingPathComponent("bak.car").path, to: app.bundlePath!.appendingPathComponent("Assets.car").path)
                }
                group.leave()
            }
        } else {
            group.enter()
            // system apps
            DispatchQueue.global(qos: .userInitiated).async {
                let webClipURL = URL(string: "/private/var/mobile/Library/WebClips/Mugunghwa-\(app.bundleIdentifier).webclip")!
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
