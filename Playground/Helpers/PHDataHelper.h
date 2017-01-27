//
//  PHDataHelper.h
//  Playground
//
//  Created by Top1 on 1/27/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHDataHelper : NSObject

+ (NSDate *)stringToDate:(NSString *)value format:(NSString *)format;
+ (NSString *)dateToString:(NSDate *)value format:(NSString *)format;

@end
