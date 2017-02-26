//
//  InboxData.h
//  Playground
//
//  Created by Administrator on 2/25/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@class ItemData;

@interface InboxData : BaseModelData

@property (nonatomic, retain) ItemData *item;

- (id)initWithDic:(NSDictionary *)data;

@end
