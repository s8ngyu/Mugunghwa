//
//  CUINamedLookup.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CUINamedLookup : NSObject
@property(copy, nonatomic) NSString *name;
@property(readonly, nonatomic) NSString *renditionName;
@property(copy, nonatomic) CUIRenditionKey *key;
@property(readonly, nonatomic) CUIThemeRendition *_rendition;
- (id)initWithName:(NSString *)arg1 usingRenditionKey:(CUIRenditionKey *)arg2 fromTheme:(unsigned long long)arg3;
@end


@interface CUINamedVectorGlyph : CUINamedLookup
- (CGImageRef)rasterizeImageUsingScaleFactor:(double)arg1 forTargetSize:(struct CGSize)arg2;
@end
