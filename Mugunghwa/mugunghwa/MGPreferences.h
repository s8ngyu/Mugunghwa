//
//  MGPreferences.h
//  mugunghwa
//
//  Created by Soongyu Kwon on 9/18/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGPreferences : NSObject
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
- (id)initWithIdentifier:(NSString *)ids;
-(void)updatePlist;
@end

NS_ASSUME_NONNULL_END
