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

@end
