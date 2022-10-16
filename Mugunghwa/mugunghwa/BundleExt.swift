//
//  BundleExt.swift
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

import Foundation


extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    var bundleName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    var executableName: String? {
        return object(forInfoDictionaryKey: "CFBundleExecutable") as? String
    }
    var nameForCatalog: String? {
        var carName = ""
        if self.bundleName != nil {
            carName = self.bundleName!
        } else if self.displayName != nil {
            carName = self.displayName!
        } else if self.executableName != nil {
            carName = self.executableName!
        }
        if carName.hasSuffix("Module") {
            carName = String(carName.dropLast(6))
        }
        if carName.hasSuffix("ControlCenter") {
            carName = String(carName.dropLast(13))
        }
        if carName.hasSuffix(".framework") {
            carName = String(carName.dropLast(10))
        }
        return carName
    }
}
