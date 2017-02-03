//
//  BidData.h
//  Playground
//
//  Created by Top1 on 2/2/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@interface BidData : BaseModelData

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger userId;

- (id)initWithDic:(NSDictionary *)data;

@end
