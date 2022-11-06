//
//  ObjcHelper.h
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/17/22.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <spawn.h>
#import <sys/sysctl.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Private)

- (BOOL)writeToCPBitmapFile:(NSString *)filename flags:(NSInteger)flags;

@end

@interface SBApplication : NSObject

@end

@interface ObjcHelper : NSObject {
    NSString *helperPath;
}
-(id)init;
-(NSNumber *)getDeviceSubType;
-(void)updateDeviceSubType:(NSInteger)deviceSubType;
-(void)imageToCPBitmap:(UIImage *)img path:(NSString *)path;
-(void)respring;
-(UIImage *)getImageFromData:(NSString *)path;
-(void)saveImage:(UIImage *)image atPath:(NSString *)path;
-(NSMutableDictionary *)getDictionaryOfPlistAtPath:(NSString *)path;
-(void)copyWithRootAt:(NSString *)at to:(NSString *)to;
-(void)moveWithRootAt:(NSString *)at to:(NSString *)to;
-(NSData *)dataForImageAt:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
