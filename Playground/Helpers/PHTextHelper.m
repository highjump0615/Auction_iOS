//
//  PHTextHelper.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PHTextHelper.h"
#import "PHColorHelper.h"

@implementation PHTextHelper

+ (UIFont*)myriadProRegular:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Regular" size:size];
}

+ (UIFont*)myriadProBold:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Bold" size:size];
}

+ (UIFont*)myriadProSemibold:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Semibold" size:size];
}



/**
 set textfield placeholder color
 @param textfield <#textfield description#>
 */
+ (void)setGrayPlaceHolder:(UITextField *)textfield {
    UIColor *colorGray = [PHColorHelper colorTextGray];
    if ([textfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                          attributes:@{NSForegroundColorAttributeName:colorGray}];
    }
}

/**
 initialize text field with regular font
 @param textfield <#textfield description#>
 */
+ (void)initTextRegular:(UITextField *)textfield {
    // font
    UIFont *fontBold = [PHTextHelper myriadProRegular:14];
    [textfield setFont:fontBold];
    
    // placeholder
    [self setGrayPlaceHolder:textfield];
}

/**
 initialize text field with bold font
 @param textfield <#textfield description#>
 */
+ (void)initTextBold:(UITextField *)textfield {
    // font
    UIFont *fontBold = [PHTextHelper myriadProBold:14];
    [textfield setFont:fontBold];
    
    // placeholder
    [self setGrayPlaceHolder:textfield];
}


@end
