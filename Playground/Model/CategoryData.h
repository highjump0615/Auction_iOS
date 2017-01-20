//
//  CategoryData.h
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryData : NSObject

@property (nonatomic) NSInteger id;
@property (nonatomic, retain) NSString *name;

+ (NSInteger)getCount;
+ (CategoryData *)getItem:(NSInteger)index;

- (id)initWithDictionary:(NSDictionary *)value;
- (NSString *)getImageName;

@end
