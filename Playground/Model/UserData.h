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

+ (UserData *)currentUser;
+ (void)setCurrentUser:(UserData *)user;

- (id)initWidthDic:(NSDictionary *)data;

@end
