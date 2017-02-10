//
//  ItemData.h
//  Playground
//
//  Created by Top1 on 1/29/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@interface ItemData : BaseModelData

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic) NSInteger category;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger condition;
@property (nonatomic) NSInteger status;

@property (nonatomic, retain) NSString *coverImage;
@property (nonatomic, retain) NSArray *imagePreview;
@property (nonatomic, retain) NSDate *dateEnd;
@property (nonatomic) NSInteger contact;

// other fields
@property (nonatomic, retain) NSString *username;
@property (nonatomic) NSInteger minuteRemain;
@property (nonatomic, retain) NSMutableArray *bids;

- (id)initWithDic:(NSDictionary *)data;
- (NSString *)remainTime;
- (NSString *)remainTimeLong;
- (NSString *)remainAuctionTimeLong:(NSInteger)minAdd;

- (NSInteger)getRemainMinutes;
- (NSString *)getCoverImageUrl;

- (NSInteger)getMaxBidUser;
- (NSInteger)getMaxBidPrice;

- (BOOL)availableToBid;
- (NSInteger)getUserRank:(id)userInfo;

- (BOOL)isMine;
- (id)getMyBid;

@end
