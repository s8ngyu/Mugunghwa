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

#define POSIX_SPAWN_PERSONA_FLAGS_OVERRIDE 1
extern int posix_spawnattr_set_persona_np(const posix_spawnattr_t* __restrict, uid_t, uint32_t);
extern int posix_spawnattr_set_persona_uid_np(const posix_spawnattr_t* __restrict, uid_t);
extern int posix_spawnattr_set_persona_gid_np(const posix_spawnattr_t* __restrict, uid_t);
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Private)

- (BOOL)writeToCPBitmapFile:(NSString *)filename flags:(NSInteger)flags;

@end

@interface SBApplication : NSObject

@end

@interface ObjcHelper : NSObject
-(id)init;
-(NSNumber *)getDeviceSubType;
-(void)updateDeviceSubType:(NSInteger)deviceSubType;
-(void)imageToCPBitmap:(UIImage *)img path:(NSString *)path;
-(void)respring;
-(UIImage *)getImageFromData:(NSString *)path;
-(void)saveImage:(UIImage *)image atPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
