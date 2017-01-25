//
//  SettingsViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "SettingsViewController.h"
#import "PHTextHelper.h"
#import "PCAlertDialog.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;

@property (weak, nonatomic) IBOutlet UIButton *mButEditProfile;
@property (weak, nonatomic) IBOutlet UIButton *mButEditSetting;
@property (weak, nonatomic) IBOutlet UIButton *mButEditNotification;
@property (weak, nonatomic) IBOutlet UIButton *mButRestartTutorial;
@property (weak, nonatomic) IBOutlet UIButton *mButDeleteAccount;
@property (weak, nonatomic) IBOutlet UIButton *mButLogOut;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // font
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    
    double dFontSize = [PHTextHelper fontSizeNormal];
    
    [self.mButEditProfile.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    [self.mButEditSetting.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    [self.mButEditNotification.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    [self.mButRestartTutorial.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    [self.mButDeleteAccount.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    [self.mButLogOut.titleLabel setFont:[PHTextHelper myriadProBold:dFontSize]];
    
    // hide tab bar
    [self.tabBarController.tabBar setHidden:YES];
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

- (IBAction)onButDeleteAccount:(id)sender {
    PCAlertDialog *viewAlert = [PCAlertDialog getView];
    viewAlert.frame = self.view.bounds;
    
    // set content
    [viewAlert setTitle:@"Delete account"];
    [viewAlert setMessage:@""];
    [viewAlert setPrimaryButName:@"Delete"];
    
    [self.view addSubview:viewAlert];
    
    [viewAlert showView:YES animated:YES];
}

- (IBAction)onButLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // back to login page
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

@end
