//
//  MGPreferences.m
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/18/22.
//

#import "MGPreferences.h"

@implementation MGPreferences
- (id)initWithIdentifier:(NSString *)ids {
    self = [super init];
    if (self) {
        _identifier = ids;
        NSString *fullPath = [@"/private/var/mobile/mugunghwa/" stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", ids]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            _dictionary = [[NSDictionary dictionaryWithContentsOfFile:fullPath] mutableCopy];
        } else {
            _dictionary = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

-(void)updatePlist {
    NSString *fullPath = [@"/private/var/mobile/mugunghwa/" stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", _identifier]];
    [_dictionary writeToFile:fullPath atomically:YES];
}
@end
