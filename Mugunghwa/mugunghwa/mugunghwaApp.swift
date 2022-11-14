//
//  mugunghwaApp.swift
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/17/22.
//

import SwiftUI
import ZipArchive

@main
struct mugunghwaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .onOpenURL() { url in
//                    NotificationCenter.default.post(name: NSNotification.Name("Theme/Installing"), object: nil)
//
//                    if url.lastPathComponent.contains("iconpack") {
//                        let fileManager = FileManager.default
//
//                        // create tmp folder
//                        try? fileManager.createDirectory(atPath: "/private/var/mobile/mugunghwa/tmp", withIntermediateDirectories: true)
//                        //unzip
//                        SSZipArchive.unzipFile(atPath: url.path, toDestination: "/private/var/mobile/mugunghwa/tmp/")
//
//                        let themes = getList(atPath: getList(atPath: URL(fileURLWithPath: "/private/var/mobile/mugunghwa/tmp")!).first!)
//                        for e in themes {
//                            try? fileManager.moveItem(atPath: e.path, toPath: "/private/var/mobile/mugunghwa/Themes/\(e.lastPathComponent)")
//                        }
//                        NotificationCenter.default.post(name: NSNotification.Name("Theme/Success"), object: nil)
//                        try? fileManager.removeItem(atPath: "/private/var/mobile/mugunghwa/tmp")
//                    } else {
//                        // not an iconpack
//                        NotificationCenter.default.post(name: NSNotification.Name("Theme/Error"), object: nil)
//                    }
//                }
        }
    }
}
