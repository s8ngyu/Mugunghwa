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


        }

        return ret;
    }
}