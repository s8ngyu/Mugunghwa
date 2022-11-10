//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ObjcHelper.h"
#import "CoreServices.h"
#import "MGPreferences.h"

#import "AssetsHeaders/CUIStructures.h"
#import "CUIRenditionKey.h"
#import "CUIThemeRendition.h"
#import "CUINamedLookup.h"
#import "CUICommonAssetStorage.h"
#import "CUIStructuredThemeStore.h"
#import "CUICatalog.h"
#import "CSIBitmapWrapper.h"
#import "CSIGenerator.h"


@interface UIImage (private)
+ (UIImage *)_applicationIconImageForBundleIdentifier:(NSString *)arg1 format:(int)arg2 scale:(double)arg3;
@end
