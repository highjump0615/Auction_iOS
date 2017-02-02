//
//  ItemData.m
//  Playground
//
//  Created by Top1 on 1/29/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemData.h"
#import "PHDataHelper.h"

@interface ItemData() {
    NSInteger mnMinOffset;
}

@end

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

            if (![PHDataHelper isObjectNull:strImage]) {
                [aryImage addObject:strImage];
            }
        }
        self.imagePreview = aryImage;
        
        // end date
        self.dateEnd = [PHDataHelper stringToDate:[data valueForKey:@"end_at"] format:@"yyyy-MM-dd HH:mm:ss"];
        
        // set other fields
        self.username = [data valueForKey:@"username"];
        self.minuteRemain = [[data valueForKey:@"minute_remain"] integerValue];
        
        // save minute offset, local time is not correct
        mnMinOffset = [self getRemainMinutes] - self.minuteRemain;
        
        // max bid
        NSDictionary *dicMaxBid = [data valueForKey:@"maxbid"];
        if (![PHDataHelper isObjectNull:dicMaxBid]) {
            self.maxBid = [[dicMaxBid valueForKey:@"price"] integerValue];
            self.maxBidUser = [[dicMaxBid valueForKey:@"user_id"] integerValue];
        }
    }
    
    return self;
}

- (NSInteger)getRemainMinutes {
    // get current date
    NSDate *dateToday = [NSDate date];
    NSTimeInterval diff = [self.dateEnd timeIntervalSinceDate:dateToday];
    
    return floor(diff / 60) - mnMinOffset;
}

- (NSString *)remainTime {

    NSInteger nMinDiff = MAX([self getRemainMinutes], 0);
    NSString *strTime = [NSString stringWithFormat:@"%02ld:%02ld", (long)nMinDiff / 60, (long)nMinDiff % 60];
    
    return strTime;
}

- (NSString *)remainTimeLong {
    NSInteger nMinDiff = MAX([self getRemainMinutes], 0);
    
    NSString *strTime = [NSString stringWithFormat:@"%ldD %02ldH %02ldM",
                         (long)nMinDiff / 60 / 24,
                         (long)nMinDiff / 60 % 24,
                         (long)nMinDiff % 60];
    return strTime;
}



@end
