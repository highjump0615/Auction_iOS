//
//  CommonUtils.h
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kApiToken       @"api_token"
#define kCurrentUser    @"current_user"

@class UserData;

@interface CommonUtils : NSObject

@property (nonatomic, retain) NSMutableArray *maryCategory;
@property (nonatomic, retain) UserData *mCurrentUser;

+ (id)sharedObject;

@end
