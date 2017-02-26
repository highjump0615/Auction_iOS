//
//  InboxData.m
//  Playground
//
//  Created by Administrator on 2/25/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "InboxData.h"
#import "ItemData.h"

@implementation InboxData

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        
        NSDictionary *dicItem = [data valueForKey:@"item"];
        self.item = [[ItemData alloc] initWithDic:dicItem];
    }
    
    return self;
}


@end
