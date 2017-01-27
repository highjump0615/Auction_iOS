//
//  UserData.m
//  Playground
//
//  Created by Top1 on 1/27/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UserData.h"
#import "CommonUtils.h"
#import "PHDataHelper.h"

@implementation UserData

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:[NSNumber numberWithInteger:self.id] forKey:@"id"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.birthday forKey:@"birthday"];
    [encoder encodeObject:[NSNumber numberWithInteger:self.gender] forKey:@"gender"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    if((self = [super init])) {
        //decode properties, other class vars
        self.id = [[decoder decodeObjectForKey:@"id"] integerValue];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.photo = [decoder decodeObjectForKey:@"photo"];
        self.birthday = [decoder decodeObjectForKey:@"birthday"];
        self.gender = [[decoder decodeObjectForKey:@"gender"] integerValue];
    }
    
    return self;
}

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
            self.birthday = [PHDataHelper stringToDate:strDate format:@"yyyy-MM-dd"];
        }
        
        self.gender = [[data valueForKey:@"gender"] integerValue];
    }
    
    return self;
}

+ (void)setCurrentUser:(UserData *)user {
    CommonUtils *utils = [CommonUtils sharedObject];
    utils.mCurrentUser = user;
    
    // save to NSUserDefault
    [user saveToUserDefault];
}

+ (UserData *)currentUser {
    CommonUtils *utils = [CommonUtils sharedObject];
    UserData *data = utils.mCurrentUser;
    
    if (!data) {
        // try to load from NSUserDefault
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSData *encodedObject = [defaults objectForKey:kCurrentUser];
        if (encodedObject) {
            data = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
            [UserData setCurrentUser:data];
        }
    }
    
    return data;
}

- (void)saveToUserDefault {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:encodedObject forKey:kCurrentUser];
    [defaults synchronize];
}

@end
