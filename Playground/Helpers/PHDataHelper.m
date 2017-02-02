//
//  PHDataHelper.m
//  Playground
//
//  Created by Top1 on 1/27/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PHDataHelper.h"

@implementation PHDataHelper


/**
 string to date

 @param value <#value description#>
 @param format <#format description#>
 @return date
 */
+ (NSDate *)stringToDate:(NSString *)value format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:value];
}

/**
 date to string

 @param value <#value description#>
 @param format <#format description#>
 @return <#return value description#>
 */
+ (NSString *)dateToString:(NSDate *)value format:(NSString *)format {
    if (!value) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:value];
}

+ (BOOL)isObjectNull:(NSObject *)object {
    return !object || [object isKindOfClass:[NSNull class]];
}


@end
