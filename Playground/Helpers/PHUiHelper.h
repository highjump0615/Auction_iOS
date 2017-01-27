//
//  PHUiHelper.h
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    // iPhone 1-4 (320x480px)
    PHDevice_iPhoneStandard     = 1,
    // iPhone 5 (320x568px)
    PHDevice_iPhone5            = 3,
    // iPhone 6-7 (375x667px)
    PHDevice_iPhone6            = 4,
    // iPhone 6-7 Plus (414x736px)
    PHDevice_iPhone6Plus        = 5,
    // Other
    PHDevice_Other              = 6
};

typedef NSUInteger PHDeviceType;

@interface PHUiHelper : NSObject

+ (PHDeviceType) deviceType;

// dimensions
+ (CGFloat) marginLeftNormal;

// ui helper
+ (void)showAlertView:(UIViewController *)viewController message:(NSString *)message;
+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message;

+ (void)makeRounded:(UIView *)view;
+ (void)setPurpleBorder:(UIView *)view cornerRadius:(double)radius;
+ (UIImage *)blueBackground;
+ (UIImage *)redBackground;


@end
