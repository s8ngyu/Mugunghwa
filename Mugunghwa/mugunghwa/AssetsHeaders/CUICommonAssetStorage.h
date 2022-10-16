//
//  CUICommonAssetStorage.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CUICommonAssetStorage : NSObject
- (NSArray *)allAssetKeys;
- (NSArray *)allRenditionNames;
- (NSData *)assetForKey:(NSData *)arg1;
- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(struct renditionkeytoken *keyList, NSData *csiData))block;
- (id)thinningArguments;
//- (const struct _renditionkeyfmt *)keyFormat;
//- (NSData *)keyFormatData;
- (long long)maximumRenditionKeyTokenCount;
- (id)initWithPath:(NSString *)arg1 forWriting:(bool)arg2;
@end


@interface CUIMutableCommonAssetStorage : CUICommonAssetStorage
- (void)setColor:(struct rgbquad)arg1 forName:(char *)arg2 excludeFromFilter:(bool)arg3;
- (bool)setAsset:(NSData *)arg1 forKey:(NSData *)arg2;
- (bool)writeToDiskAndCompact:(bool)arg1;
@end
