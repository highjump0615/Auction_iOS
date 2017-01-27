//
//  UserData.m
//  Playground
//
//  Created by Top1 on 1/27/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UserData.h"
#import "CommonUtils.h"

@implementation UserData

- (id)initWidthDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        self.name = [data valueForKey:@"name"];
        self.username = [data valueForKey:@"username"];
        self.email = [data valueForKey:@"email"];
        self.photo = [data valueForKey:@"photo"];
        
        // set date
        NSString *strDate = [data valueForKey:@"birthday"];
        if (strDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
            
            [formatter setTimeZone:timeZone];
            [formatter setDateFormat : @"yyyy-MM-dd"];
            
            self.birthday = [formatter dateFromString:strDate];
        }
        
        self.gender = [[data valueForKey:@"gender"] integerValue];
    }
    
    return self;
}

+ (void)setCurrentUser:(UserData *)user {
    CommonUtils *utils = [CommonUtils sharedObject];
    utils.mCurrentUser = user;
}

+ (UserData *)currentUser {
    CommonUtils *utils = [CommonUtils sharedObject];
    return utils.mCurrentUser;
}


@end
