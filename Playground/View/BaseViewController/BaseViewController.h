//
//  BaseViewController.h
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)initLoginButton:(UIButton *)button;
- (void)initRoundButton:(UIButton *)button;
- (void)dismissKeyboard:(UITapGestureRecognizer *) sender;

@end
