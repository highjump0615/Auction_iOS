//
//  LandingViewController.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "LandingViewController.h"
#import "PHTextHelper.h"

@interface LandingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *mButFacebook;
@property (weak, nonatomic) IBOutlet UIButton *mButSignup;
@property (weak, nonatomic) IBOutlet UIButton *mButLogin;

@property (weak, nonatomic) IBOutlet UILabel *mLblOr;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // init appearance of the controls
    //
    UIFont *fontRegular = [PHTextHelper myriadProRegular:14];
    
    // signin button
    [self initLoginButton:self.mButSignup];
    
    // facebook button
    [self initLoginButton:self.mButFacebook];
    
    // or label
    [self.mLblOr setFont:fontRegular];
    
    // other buttons
    [self.mButLogin.titleLabel setFont:fontRegular];
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

@end
