@import Foundation;
#import <sys/stat.h>
#import <dlfcn.h>
#import <spawn.h>
#import <objc/runtime.h>
#import <SpringBoardServices/SpringBoardServices.h>


int main(int argc, char *argv[], char *envp[]) {
    @autoreleasepool {
        if (argc <= 1) return -1;

        NSLog(@"mugunghwahelper go, uid: %d, gid: %d", getuid(), getgid());

        NSBundle* mcmBundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
		[mcmBundle load];

		int ret = 0;

		NSString* cmd = [NSString stringWithUTF8String:argv[1]];
        NSString* a = [NSString stringWithUTF8String:argv[0]];
        NSString* b = [NSString stringWithUTF8String:argv[2]];
        if ([cmd isEqualToString:@"test"]) {
            NSLog(@"mugunghwahelper = %d", argc);

            NSLog(@"mugunghwahelper = %@", a);
            NSLog(@"mugunghwahelper = %@", cmd);
            NSLog(@"mugunghwahelper = %@", b);
            [[NSFileManager defaultManager] createFileAtPath:@"/var/containers/Bundle/Application/B7C3B77E-AFA6-41D1-9B7C-57D430C7636F/Music.app/test" contents:nil attributes:nil];
        }

        return ret;
    }
}