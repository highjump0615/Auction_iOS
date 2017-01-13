//
//  BaseViewController.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"
#import "PHTextHelper.h"
#import "PCNavbarView.h"

@interface BaseViewController ()

@property (weak, nonatomic) IBOutlet UIView *mViewNavbar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add navigation bar view
    PCNavbarView *viewNavbar = [PCNavbarView getView];
    viewNavbar.frame = self.mViewNavbar.bounds;
    
    // back button
    [viewNavbar.mButBack addTarget:self action:@selector(onButBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mViewNavbar addSubview:viewNavbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 Initialize signup & login buttons
 */
- (void)initLoginButton:(UIButton *)button {
    // make them rounded
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:7];
    [button.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
}

/**
 Initialize round buttons
 */
- (void)initRoundButton:(UIButton *)button {
    // make them rounded
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:button.frame.size.height / 2.0];
    [button.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
}

/**
 Hides keyboard
 @param sender -
 */
- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.view endEditing:YES];
}


/**
 back to prev page
 @param sender sender description
 */
- (void)onButBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
