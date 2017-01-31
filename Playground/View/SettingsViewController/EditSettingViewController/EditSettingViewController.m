//
//  EditSettingViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "EditSettingViewController.h"
#import "PHTextHelper.h"
#import "UserData.h"
#import "PHUiHelper.h"
#import "ApiManager.h"
#import "ApiConfig.h"

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
    [self.mLblSocial setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblFacebook setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeNormal]]];
    [self.mLblTwitter setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeNormal]]];
    
    // set content
    UserData *user = [UserData currentUser];
    [self.mTxtEmail setText:user.email];
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
 back to prev page
 @param sender sender description
 */
- (void)onButBack:(id)sender {
    
    UserData *user = [UserData currentUser];
    
    // ------ Edit setting, save
    
    // check data validity
    if (self.mTxtEmail.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your email"];
        return;
    }
    if (self.mTxtPswdNew.text.length > 0 && ![self.mTxtPswdNew.text isEqualToString:self.mTxtPswdRetype.text]) {
        [PHUiHelper showAlertView:self message:@"Password does not match"];
        return;
    }
    
    // save profile
    [[ApiManager sharedInstance] saveSettingwithEmail:self.mTxtEmail.text
                                             password:self.mTxtPswdNew.text
                                          oldpassword:self.mTxtPswdOld.text
                                              success:^(id response)
     {
         [user updateProfile:response];
         [UserData setCurrentUser:user];
         
         // go to prev page
         [super onButBack:sender];

     }
                                                 fail:^(NSError *error, id response)
     {
         // close keyboard
         [self.view endEditing:YES];
         
         [PHUiHelper showAlertView:self title:@"Update Failed" message:[ApiManager getErrorDescription:error response:response]];
     }];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.mTxtEmail) {
        [textField resignFirstResponder];
    }
    else if (textField == self.mTxtPswdOld) {
        [self.mTxtPswdNew becomeFirstResponder];
    }
    else if (textField == self.mTxtPswdNew) {
        [self.mTxtPswdRetype becomeFirstResponder];
    }
    else if (textField == self.mTxtPswdRetype) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


@end
