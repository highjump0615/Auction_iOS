//
//  PHTextHelper.h
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHTextHelper : NSObject

+ (NSInteger)fontSizeSmall;
+ (NSInteger)fontSizeMedium;
+ (NSInteger)fontSizeNormal;
+ (NSInteger)fontSizeNormalLarge;
+ (NSInteger)fontSizeSemiLarge;
+ (NSInteger)fontSizeLarge;

+ (NSInteger)fontNoticeSmall;
+ (NSInteger)fontNoticeMedium;

+ (UIFont *)myriadProRegular:(CGFloat)size;
+ (UIFont *)myriadProBold:(CGFloat)size;
+ (UIFont*)myriadProBlack:(CGFloat)size;
+ (UIFont*)myriadProLight:(CGFloat)size;
+ (UIFont*)myriadProSemibold:(CGFloat)size;

// textfield functions
+ (void)initTextRegular:(UITextField *)textfield;
+ (void)initTextBold:(UITextField *)textfield;

@end
