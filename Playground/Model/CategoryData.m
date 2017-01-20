//
//  Category.m
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryData.h"
#import "CommonUtils.h"

@implementation CategoryData

+ (NSInteger)getCount {
    CommonUtils *utils = [CommonUtils sharedObject];
    return [utils.maryCategory count];
}

+ (CategoryData *)getItem:(NSInteger)index {
    CommonUtils *utils = [CommonUtils sharedObject];
    return utils.maryCategory[index];
}


- (id)initWithDictionary:(NSDictionary *)value {
    self.id = [[value objectForKey:@"id"] integerValue];
    self.name = [value objectForKey:@"name"];
    
    return self;
}

/**
 get image file name of the category
 @return <#return value description#>
 */
- (NSString *)getImageName {
    NSString *strName = [NSString stringWithFormat:@"ct%02d", (int)self.id];
    return strName;
}

@end
