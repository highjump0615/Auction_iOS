//
//  BidData.m
//  Playground
//
//  Created by Top1 on 2/2/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidData.h"

@implementation BidData

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        self.price = [[data valueForKey:@"price"] integerValue];
        self.userId = [[data valueForKey:@"user_id"] integerValue];
    }
    
    return self;
}

@end
