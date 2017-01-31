//
//  CommentData.m
//  Playground
//
//  Created by Top1 on 1/30/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CommentData.h"
#import "UserData.h"
#import "PHDataHelper.h"

@implementation CommentData

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        self.comment = [data valueForKey:@"comment"];
        self.username = [data valueForKey:@"username"];
        
        self.createdAt = [PHDataHelper stringToDate:[data valueForKey:@"created_at"] format:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

- (id)initWithText:(NSString *)comment parent:(CommentData *)parent {
    
    self = [super init];
    
    if (self) {
        self.comment = comment;
        self.username = [UserData currentUser].username;
        self.createdAt = [NSDate date];
        
        // set parent
        if (parent) {
            self.parent = parent;
        }
    }
    
    return self;
}



@end
