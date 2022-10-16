//
//  CSIGenerator.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CSIGenerator : NSObject
@property(copy, nonatomic) NSString *name;
@property(nonatomic) int blendMode;
@property(nonatomic) short colorSpaceID;
@property(nonatomic) int exifOrientation;
@property(nonatomic) double opacity;
@property(nonatomic) unsigned int scaleFactor;
@property(nonatomic) long long templateRenderingMode;
@property(copy, nonatomic) NSString *utiType;
@property(nonatomic) bool isRenditionFPO;
@property(nonatomic, getter=isExcludedFromContrastFilter) bool excludedFromContrastFilter;
@property(nonatomic) bool isVectorBased;
- (void)addBitmap:(CSIBitmapWrapper *)arg1;
- (void)addSliceRect:(struct CGRect)arg1;
- (NSData *)CSIRepresentationWithCompression:(bool)arg1;
- (id)initWithCanvasSize:(struct CGSize)arg1 sliceCount:(unsigned int)arg2 layout:(short)arg3;
@end
