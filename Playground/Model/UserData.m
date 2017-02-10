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
#import "ApiManager.h"
#import "ApiConfig.h"
#import "ItemData.h"

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
        
        self.auctionItems = [[NSMutableArray alloc] init];
        self.bidItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];

        [self updateEmail:data];
        [self updateProfile:data];
        
        self.auctionItems = [[NSMutableArray alloc] init];
        self.bidItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)updateProfile:(NSDictionary *)data {
    self.name = [data valueForKey:@"name"];
    self.username = [data valueForKey:@"username"];
    self.photo = [data valueForKey:@"photo"];
    
    // set date
    NSString *strDate = [data valueForKey:@"birthday"];
    if (strDate) {
        self.birthday = [PHDataHelper stringToDate:strDate format:@"yyyy-MM-dd"];
    }
    
    self.gender = [[data valueForKey:@"gender"] integerValue];
}

- (void)updateEmail:(NSDictionary *)data {
    self.email = [data valueForKey:@"email"];
}

+ (void)setCurrentUser:(UserData *)user {
    CommonUtils *utils = [CommonUtils sharedObject];
    utils.mCurrentUser = user;
    
    if (user) {
        // save to NSUserDefault
        [user saveToUserDefault];
    }
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
            
            utils.mCurrentUser = data;
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

/**
 get url of photo
 @return url
 */
- (NSString *)photoUrl {
    return [NSString stringWithFormat:@"%@%@", PH_API_BASE_USER_FILE_URL, self.photo];
}

- (void)fetchAuctionItems:(NSArray *)aryDic {
    // clear data
    [self.auctionItems removeAllObjects];
    
    for (NSDictionary *dicItem in aryDic) {
        ItemData *iData = [[ItemData alloc] initWithDic:dicItem];
        [self.auctionItems addObject:iData];
    }
}

- (void)fetchBidItems:(NSArray *)aryDic {
    // clear data
    [self.bidItems removeAllObjects];
    
    for (NSDictionary *dicItem in aryDic) {
        ItemData *iData = [[ItemData alloc] initWithDic:dicItem];
        [self.bidItems addObject:iData];
    }
}

@end
