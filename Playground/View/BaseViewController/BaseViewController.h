//
//  BaseViewController.h
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

// navbar
- (void)showSearch:(BOOL)showSearch showBack:(BOOL)showBack;
- (void)showTitle:(BOOL)show;
- (void)setSearchDelegate:(UIViewController<UITextFieldDelegate> *)controller;
- (NSString *)getSearchString;
- (void)setSearchString:(NSString *)value;
- (void)showNavbarCongrat:(BOOL)show;

- (void)setGestureRecognizer;

// controls
- (void)initLoginButton:(UIButton *)button;
- (void)initRoundButton:(UIButton *)button;
- (void)initTableView:(UITableView *)tableview haveBottombar:(BOOL)haveBottombar;

// actions
- (void)enableKeyboardNotification;
- (void)dismissKeyboard:(UITapGestureRecognizer *) sender;

// delegations
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
