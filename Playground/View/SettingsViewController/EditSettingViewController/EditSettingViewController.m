//
//  EditSettingViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "EditSettingViewController.h"
#import "PHTextHelper.h"

@interface EditSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mTxtEmail;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPswdOld;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPswdNew;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPswdRetype;

@property (weak, nonatomic) IBOutlet UILabel *mLblSocial;
@property (weak, nonatomic) IBOutlet UILabel *mLblFacebook;
@property (weak, nonatomic) IBOutlet UILabel *mLblTwitter;

@end

@implementation EditSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init text field
    [PHTextHelper initTextBold:self.mTxtEmail];
    [PHTextHelper initTextBold:self.mTxtPswdOld];
    [PHTextHelper initTextBold:self.mTxtPswdNew];
    [PHTextHelper initTextBold:self.mTxtPswdRetype];
    
    // label
    [self.mLblSocial setFont:[PHTextHelper myriadProRegular:14]];
    [self.mLblFacebook setFont:[PHTextHelper myriadProBold:14]];
    [self.mLblTwitter setFont:[PHTextHelper myriadProBold:14]];
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
