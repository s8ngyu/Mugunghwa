//
//  CoreUI_Reference.swift
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

#if DEBUG

struct CoreUI_Reference {
    
    //A. Enumerate & initialize CUIThemeRenditions
    // 1. via CUICommonAssetStorage
    func enumerateThemeStorage(carPath: String) -> [CUIThemeRendition]? {
        guard let assetStorage = CUICommonAssetStorage(path: carPath, forWriting: false) else { return nil }
        var renditions: [CUIThemeRendition] = []
        assetStorage.enumerateKeysAndObjects { keytoken, csiData in
            let cuiRendition = CUIThemeRendition(csiData: csiData, forKey: keytoken)
            renditions.append(cuiRendition!)
        }
        return renditions
    }
    // 2. via CUIStructuredThemeStore
    func enumerateThemeStore(carPath: String) -> [CUIThemeRendition]? {
        guard
            let themeStore = CUIStructuredThemeStore(path: carPath),
            let renditionKeys = themeStore.store().allAssetKeys() as? [CUIRenditionKey]
            else { return nil }
        var renditions: [CUIThemeRendition] = []
        for key in renditionKeys {
            if let cuiRendition = themeStore.rendition(withKey: key.keyList()) {
                renditions.append(cuiRendition)
            }
        }
        return renditions
    }
    // 3. via CUICatalog (least efficient and seems not able to retreive _CUINameContentRendition)
    func enumerateCatalog(carPath: String) -> [CUIThemeRendition]? {
        guard let catalog = try? CUICatalog(url: URL(fileURLWithPath: carPath)) else { return nil }
        var renditions: [CUIThemeRendition] = []
        catalog.enumerateNamedLookups { namedAsset in
            let cuiRendition = namedAsset?._rendition
            renditions.append(cuiRendition!)
        }
        return renditions
    }
    
    //B. Extract Rendition Attribute Sequence from Key Format
    func attributeOrderFrom(keyfmtData: Data) -> [UInt16] {
        //let keyfmtData = assetStorage.keyFormatData() as! Data
        var keyfmt = [UInt32](repeating: 0, count: keyfmtData.count/MemoryLayout<UInt32>.stride)
        _ = keyfmt.withUnsafeMutableBytes { keyfmtData.copyBytes(to: $0) }
        return keyfmt.dropFirst(3).map{UInt16($0)} // drop the first three Int ("tag", "version" and "maximumRenditionKeyTokenCount" respectively) to get the keyToken list/order
    }
    
    //C Create RenditionKey manually with pointers (Experimental)
    func attributesToKeyTokenPointers(attributes: [Int?]) -> UnsafePointer<renditionkeytoken> {
        let tokenCount = attributes.compactMap{$0}.count + 1  // = tokenCount = maximumRenditionKeyTokenCount (plus 1 for a trailing nil?)
        let tokenBuffer = UnsafeMutablePointer<renditionkeytoken>.allocate(capacity: tokenCount)
        tokenBuffer.initialize(repeating: renditionkeytoken(identifier: 0, value: 0), count: tokenCount)
        var i = 0
        for (index, value) in attributes.enumerated() {
            if value != nil {
                tokenBuffer.advanced(by: i).pointee = renditionkeytoken(identifier: UInt16(index), value: UInt16(value ?? 0))
                i += 1
            }
        }
        let syntheticKeyToken = UnsafePointer(tokenBuffer)
        tokenBuffer.deinitialize(count: tokenCount)
        tokenBuffer.deallocate()
        
        //To extract attributes from keyToken:
        let keyToken = syntheticKeyToken
        for i in 0...tokenCount { //or use the maximumRenditionKeyTokenCount in renditionkeyfmt
            let id = keyToken.advanced(by: i).pointee.identifier
            let value = keyToken.advanced(by: i).pointee.value
            print("Rendition Attribute - id: \(id) value: \(value)")
        }
        
        return syntheticKeyToken
    }
    
    //D. RenditionKey to CarKeyData
    // 1. via CUIStructuredThemeStore
    func renditionKeyToCARKey(carPath: String, keyToken: UnsafePointer<renditionkeytoken>) -> Data? {
        guard let themeStore = CUIStructuredThemeStore(path: carPath) else { return nil }
        return themeStore.convertRenditionKey(toKeyData: keyToken)
    }
    // 2. via C function (Experimental)
    /*
    func renditionKeyToCARKeyC(keyToken: UnsafePointer<renditionkeytoken>, keyFormat: UnsafePointer<renditionkeyfmt>) -> NSData? {
        let keyCount = Int(keyFormat.pointee.maximumRenditionKeyTokenCount) * MemoryLayout<Int16>.size
        let bufferPointer = UnsafeMutablePointer<UInt16>.allocate(capacity: keyCount)
        bufferPointer.initialize(repeating: 0, count: keyCount)
        let keyTokenPointer = UnsafeMutablePointer<renditionkeytoken>.allocate(capacity: keyCount)
        keyTokenPointer.initialize(from: keyToken, count: keyCount)
        CUIFillCARKeyArrayForRenditionKey(bufferPointer, keyTokenPointer, keyFormat)
        let carKeyData = NSData(bytesNoCopy: bufferPointer, length: keyCount, freeWhenDone: true)
        bufferPointer.deinitialize(count: keyCount)
        bufferPointer.deallocate()
        keyTokenPointer.deinitialize(count: keyCount)
        keyTokenPointer.deallocate()
        return carKeyData
    }*/
    
    // E. keySignature to CarKeyData (Experimental)
    func keySignatureToCARKey(keySignature: String) -> Data? {
        //KeySignature Example: "0{0-0-3-1-0-0-0-0-0-0-0-0-0-0-0-0-1c83-55-dc-0-0"
        let keyString = keySignature.dropFirst(2)  // drop the first two characters, i.e. "0{"
        let hexArray = keyString.components(separatedBy: "-")
        let carKeyArray = hexArray.map { UInt16($0, radix: 16)!} //Map hex string to UInt16 (array)
        let carKeyData = carKeyArray.withUnsafeBufferPointer{Data(buffer: $0)}
        return carKeyData
    }
    
    //F. CarKeyData to CarKey (Array of UInt16)
    func carKeyDataToCARKeyArray(keyData: Data) -> [UInt16]? {
        var carKeyArray = Array<UInt16>(repeating: 0, count: keyData.count/MemoryLayout<UInt16>.stride)
        _ = carKeyArray.withUnsafeMutableBytes { keyData.copyBytes(to: $0) }
        return carKeyArray
    }
    
    //G. Pixel Format to File Type String
    func pixelFormatToFileType(pixelFmt: Int) -> String {
        // pixelFormat e.g.: 1095911234
        let chars = [24, 16, 8, 0].map { Character(UnicodeScalar(UInt8(pixelFmt >> $0 & 0xFF)))}
        return String(chars)
    }
    
    
}

#endif
