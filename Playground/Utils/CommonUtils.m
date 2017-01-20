//
//  CommonUtils.m
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (id)sharedObject {
    static CommonUtils *utils = nil;
    if (!utils) {
        utils = [[CommonUtils alloc] init];
        
        // init
        utils.maryCategory = [[NSMutableArray alloc] init];
    }
    
    return utils;
}

@end
