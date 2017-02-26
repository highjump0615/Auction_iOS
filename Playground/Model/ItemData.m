//
//  ItemData.m
//  Playground
//
//  Created by Top1 on 1/29/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemData.h"
#import "PHDataHelper.h"
#import "BidData.h"
#import "UserData.h"
#import "ApiConfig.h"

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
        self.rate = [[data valueForKey:@"rate"] integerValue];
        
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
        self.contact = [[data valueForKey:@"contact"] integerValue];
        
        // set other fields
        self.user = [[UserData alloc] initWithDic:[data valueForKey:@"userdata"]];
        self.minuteRemain = [[data valueForKey:@"minute_remain"] integerValue];
        
        // save minute offset, local time is not correct
        mnMinOffset = [self getRemainMinutes] - self.minuteRemain;
        
        // max bid
        self.bids = [[NSMutableArray alloc] init];
        NSArray *aryMaxBid = [data valueForKey:@"maxbid"];
        for (NSDictionary *dicBid in aryMaxBid) {
            BidData *bidData = [[BidData alloc] initWithDic:dicBid];
            [self.bids addObject:bidData];
        }
    }
    
    return self;
}

- (NSInteger)getRemainMinutes {
    // get current date
    NSDate *dateToday = [NSDate date];
    
    // end time in normal case
    NSDate *dateTarget = self.dateEnd;
    
    // if someone gave up, give up time is target
    for (BidData *bid in self.bids) {
        if (bid.dateGiveup) {
            dateTarget = bid.dateGiveup;
        }
    }
    
    NSTimeInterval diff = [dateTarget timeIntervalSinceDate:dateToday];
    
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

/**
 minutes difference after bid is over
 @param minAdd 24 hours or 48 hours
 @return <#return value description#>
 */
- (NSString *)remainAuctionTimeLong:(NSInteger)minAdd {
    NSInteger nMinDiff = [self getRemainMinutes];
    nMinDiff = nMinDiff + minAdd;
    
    NSString *strTime = [NSString stringWithFormat:@"%02ldH %02ldM",
                         (long)nMinDiff / 60,
                         (long)nMinDiff % 60];
    return strTime;
}


/**
 get max bid user id
 @return <#return value description#>
 */
- (NSInteger)getMaxBidUser {
    NSInteger nUserId = 0;
    
    for (BidData *bid in self.bids) {
        // except given up bids
        if (bid.dateGiveup) {
            continue;
        }
        
        nUserId = bid.userId;
        break;
    }
    
    return nUserId;
}

/**
 get max bid price
 @return <#return value description#>
 */
- (NSInteger)getMaxBidPrice {
    NSInteger nPrice = 0;
    
    for (BidData *bid in self.bids) {
        // except given up bids
        if (bid.dateGiveup) {
            continue;
        }
        
        nPrice = bid.price;
        break;
    }
    
    return nPrice;
}

- (BOOL)availableToBid {
    return [self getRemainMinutes] > 0;
}

/**
 get user bid rank
 @param userInfo UserData
 @return -1: not in top 3, 0~2: rank
 */
- (NSInteger)getUserRank:(id)userInfo {
    NSInteger nRank = -1, nRankTemp = -1;
    UserData *user = (UserData *)userInfo;
    
    for (BidData *bData in self.bids) {
        // skip given up bids
        if (bData.dateGiveup) {
            continue;
        }
        
        nRankTemp++;
        
        if (bData.userId == user.id) {
            nRank = nRankTemp;
            break;
        }
    }
    
    return nRank;
}

/**
 get current user's bid of the item
 @return <#return value description#>
 */
- (id)getMyBid {
    BidData *bData;
    UserData *user = [UserData currentUser];
    
    for (BidData *bid in self.bids) {
        if (bid.userId == user.id) {
            bData = bid;
            break;
        }
    }
    
    return bData;
}

/**
 get url of cover image
 @return <#return value description#>
 */
- (NSString *)getCoverImageUrl {
    return [NSString stringWithFormat:@"%@%@", PH_API_BASE_ITEM_FILE_URL, self.coverImage];
}

/**
 get user name of item
 @return <#return value description#>
 */
- (NSString *)username {
    return self.user.username;
}

/**
 determin it is current user's item
 @return <#return value description#>
 */
- (BOOL)isMine {
    UserData *user = [UserData currentUser];
    if ([self.username isEqualToString:user.username]) {
        return YES;
    }
    
    return NO;
}

@end
