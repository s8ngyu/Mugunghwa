//
//  CUIStructuredThemeStore.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CUIStructuredThemeStore : NSObject
- (CUICommonAssetStorage *)store;
- (CUIThemeRendition *)renditionWithKey:(const struct renditionkeytoken *)arg1;
- (NSString *)renditionNameForKeyList:(const struct renditionkeytoken *)arg1;
- (NSData *)convertRenditionKeyToKeyData:(const struct renditionkeytoken *)arg1;
- (NSData *)lookupAssetForKey:(const struct renditionkeytoken *)arg1;
- (id)initWithPath:(NSString *)arg1;
@end
