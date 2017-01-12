//
//  BaseViewController.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"
#import "PHTextHelper.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
 Hides keyboard
 @param sender -
 */
-(void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.view endEditing:YES];
}


@end
