//
//  PHUiHelper.m
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PHUiHelper.h"


@implementation PHUiHelper


/**
 determine iphone devices
 @return <#return value description#>
 */
+ (PHDeviceType) deviceType {
    PHDeviceType nResult = PHDevice_iPhoneStandard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            // get screen size
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            // get resolution
//            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            
            if (result.height >= 736.0f)
                nResult = PHDevice_iPhone6Plus;
            else if (result.height >= 667.0f)
                nResult = PHDevice_iPhone6;
            else if (result.height >= 568.0f)
                nResult = PHDevice_iPhone5;
        }
    }
    else {
        nResult = PHDevice_Other;
    }
    
    return nResult;
}


/**
 show alert view
 @param viewController <#viewController description#>
 @param message <#message description#>
 */
+ (void)showAlertView:(UIViewController *)viewController message:(NSString *)message {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:message
                                                                message:@""
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    // ok button
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [ac addAction:okAction];
    
    [viewController presentViewController:ac animated:YES completion:nil];
}

+ (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    // ok button
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [ac addAction:okAction];
    
    [viewController presentViewController:ac animated:YES completion:nil];
}


+ (CGFloat) marginLeftNormal {
    return 16.0f;
}

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

+ (UIImage *)blueBackground {
    return [UIImage imageNamed:@"blue_bg"];
}

+ (UIImage *)redBackground {
    return [UIImage imageNamed:@"red_bg"];
}

@end
