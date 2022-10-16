//
//  CSIBitmapWrapper.h
//  Aphrodite
//
//  Copyright © 2020 Joey. All rights reserved.
//

@interface CSIBitmapWrapper : NSObject
- (CGContextRef *)bitmapContext;
- (id)initWithPixelWidth:(unsigned int)arg1 pixelHeight:(unsigned int)arg2;
@end
