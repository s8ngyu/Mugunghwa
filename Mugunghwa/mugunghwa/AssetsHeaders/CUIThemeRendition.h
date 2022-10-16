//
//  CUIThemeRendition.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CUIThemeRendition : NSObject
@property(nonatomic) long long type;
@property(nonatomic) unsigned int subtype;
@property(nonatomic) int blendMode;
@property(nonatomic) int exifOrientation;
@property(nonatomic) double opacity;
@property(readonly, nonatomic) NSData *srcData;
- (const struct renditionkeytoken *)key;
- (NSString *)name;
- (unsigned long long)colorSpaceID;
- (double)scale;
- (long long)templateRenderingMode;
- (NSString *)utiType;
- (bool)isHeaderFlaggedFPO;
- (struct cuithemerenditionrenditionflags *)renditionFlags;
- (bool)isVectorBased;
- (int)pixelFormat;
- (bool)isInternalLink;
- (CUIRenditionKey *)linkingToRendition;
- (struct CGRect)_destinationFrame;
- (CGImageRef)unslicedImage;
- (CGColorRef)cgColor;
- (bool)substituteWithSystemColor;
- (NSString *)systemColorName;
- (CGImageRef)createImageFromPDFRenditionWithScale:(double)arg1;
- (struct CGRect)_destinationFrame;
- (struct CGSize)unslicedSize;
- (id)initWithCSIData:(NSData *)arg1 forKey:(const struct renditionkeytoken *)arg2;
@end


@interface _CUIThemeSVGRendition : CUIThemeRendition
- (id)rawData;
@end


@interface _CUIRawDataRendition : CUIThemeRendition
- (id)data;
@end
