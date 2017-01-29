//
//  ItemData.m
//  Playground
//
//  Created by Top1 on 1/29/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemData.h"

@implementation ItemData

- (id)initWithDic:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.id = [[data valueForKey:@"id"] integerValue];
        self.title = [data valueForKey:@"title"];
        self.desc = [data valueForKey:@"desc"];
        self.category = [[data valueForKey:@"category"] integerValue];
        self.price = [[data valueForKey:@"price"] integerValue];
        self.condition = [[data valueForKey:@"condition"] integerValue];
        
        self.status = [[data valueForKey:@"status"] integerValue];
        
        self.coverImage = [data valueForKey:@"image0"];
        
        // set preview images
        NSMutableArray *aryImage = [[NSMutableArray alloc] init];
        
        for (int i = 1; i <= 3; i++) {
            NSString *strImage = [data valueForKey:[NSString stringWithFormat:@"image%d", i]];
            if (strImage) {
                [aryImage addObject:strImage];
            }
        }
    }
    
    return self;
}


@end
