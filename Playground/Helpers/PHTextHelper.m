//
//  PHTextHelper.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"

@implementation PHTextHelper

+ (NSInteger)fontSizeSmall {
    return 11;
}

+ (NSInteger)fontSizeMedium {
    return 13;
}

+ (NSInteger)fontSizeNormal {
    return 15;
}

+ (NSInteger)fontSizeNormalLarge {
    return 22;
}

+ (NSInteger)fontSizeSemiLarge {
    return 30;
}

+ (NSInteger)fontSizeLarge {
    return 40;
}

+ (NSInteger)fontNoticeSmall {
    return 20;
}

+ (NSInteger)fontNoticeMedium {
    return 24;
}


+ (UIFont*)myriadProRegular:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Regular" size:size];
}

+ (UIFont*)myriadProBold:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Bold" size:size];
}

+ (UIFont*)myriadProBlack:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Black" size:size];
}

+ (UIFont*)myriadProLight:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Light" size:size];
}

+ (UIFont*)myriadProSemibold:(CGFloat)size {
    return [UIFont fontWithName:@"MyriadPro-Semibold" size:size];
}



/**
 set textfield placeholder color
 @param textfield <#textfield description#>
 */
+ (void)setGrayPlaceHolder:(UITextField *)textfield {

    // check validity
    if (![textfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        return;
    }
    
    if (!textfield.placeholder) {
        return;
    }

    UIColor *colorGray = [PHColorHelper colorTextGray];
    textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                      attributes:@{NSForegroundColorAttributeName:colorGray}];
}

/**
 initialize text field with regular font
 @param textfield <#textfield description#>
 */
+ (void)initTextRegular:(UITextField *)textfield {
    // font
    UIFont *fontRegular = [PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]];
    [textfield setFont:fontRegular];
    
    // placeholder
    [self setGrayPlaceHolder:textfield];
}

/**
 initialize text field with bold font
 @param textfield <#textfield description#>
 */
+ (void)initTextBold:(UITextField *)textfield {
    // font
    UIFont *fontBold = [PHTextHelper myriadProBold:[PHTextHelper fontSizeNormal]];
    [textfield setFont:fontBold];
    
    // placeholder
    [self setGrayPlaceHolder:textfield];
}


@end
