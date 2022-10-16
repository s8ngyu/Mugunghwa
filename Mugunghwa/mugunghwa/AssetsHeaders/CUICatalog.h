//
//  CUICatalog.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CUICatalog : NSObject
@property(nonatomic) unsigned long long storageRef;
- (void)enumerateNamedLookupsUsingBlock:(void (^)(CUINamedLookup *namedAsset))block;
- (CUIStructuredThemeStore *)_themeStore;
- (id)initWithURL:(NSURL *)url error:(NSError **)error;
@end
