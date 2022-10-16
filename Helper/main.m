@import Foundation;
#import <sys/stat.h>
#import <dlfcn.h>
#import <spawn.h>
#import <objc/runtime.h>
#import <SpringBoardServices/SpringBoardServices.h>


int main(int argc, char *argv[], char *envp[]) {
    @autoreleasepool {
        if (argc <= 1) return -1;
        NSBundle* mcmBundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
		[mcmBundle load];

		int ret = 0;

		NSString *cmd = [NSString stringWithUTF8String: argv[1]];
        NSLog(@"%@ %d", cmd, argc);

        if ([cmd isEqualToString: @"cp"]) {
            if (argc <= 3) return -3;
            NSString *at = [NSString stringWithUTF8String: argv[2]];
            NSString *to = [NSString stringWithUTF8String: argv[3]];
            [[NSFileManager defaultManager] copyItemAtPath: at toPath: to error:nil];
        } else if ([cmd isEqualToString: @"mv"]) {
            if (argc <= 3) return -3;
            NSString *at = [NSString stringWithUTF8String: argv[2]];
            NSString *to = [NSString stringWithUTF8String: argv[3]];
            [[NSFileManager defaultManager] removeItemAtPath: to error: nil];
            [[NSFileManager defaultManager] moveItemAtPath: at toPath: to error:nil];
        }

        return ret;
    }
}