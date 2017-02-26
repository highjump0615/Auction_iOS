//
//  UserData.h
//  Playground
//
//  Created by Top1 on 1/27/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@interface UserData : BaseModelData

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSDate *birthday;
@property (nonatomic) NSInteger gender;

// other fields
@property (nonatomic, retain) NSMutableArray *auctionItems;
@property (nonatomic, retain) NSMutableArray *bidItems;
@property (nonatomic) NSInteger countGivenUp;
@property (nonatomic) NSInteger rate;


+ (UserData *)currentUser;
+ (void)setCurrentUser:(UserData *)user;

- (id)initWithDic:(NSDictionary *)data;
- (void)updateProfile:(NSDictionary *)data;
- (void)updateEmail:(NSDictionary *)data;

- (NSString *)photoUrl;

- (void)fetchAuctionItems:(NSArray *)aryDic;
- (void)fetchBidItems:(NSArray *)aryDic;

@end
