//
//  CategoryData.h
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@interface CategoryData : BaseModelData

@property (nonatomic, retain) NSString *name;

+ (NSInteger)getCount;
+ (CategoryData *)getItem:(NSInteger)index;

- (id)initWithDictionary:(NSDictionary *)value;
- (NSString *)getImageName;

@end
