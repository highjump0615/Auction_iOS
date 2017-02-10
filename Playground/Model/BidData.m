//
//  BidData.m
//  Playground
//
//  Created by Top1 on 2/2/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidData.h"
#import "PHDataHelper.h"

@implementation BidData

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        self.price = [[data valueForKey:@"price"] integerValue];
        self.userId = [[data valueForKey:@"user_id"] integerValue];
        self.dateGiveup = [PHDataHelper stringToDate:[data valueForKey:@"giveup_at"] format:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

@end
