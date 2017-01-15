//
//  PHUiHelper.m
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PHUiHelper.h"

@implementation PHUiHelper

+ (void)makeRounded:(UIView *)view {
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:view.frame.size.height/2.0];
}

+ (void)setPurpleBorder:(UIView *)view cornerRadius:(double)radius {
    
    // make border
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderColor:[UIColor colorWithRed:122/255.0
                                                    green:167/255.0
                                                     blue:244/255.0
                                                    alpha:1.0].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    [view.layer setCornerRadius:radius];
}

@end
