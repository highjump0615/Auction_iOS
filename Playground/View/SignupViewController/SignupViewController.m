//
//  SignupViewController.m
//  Playground
//
//  Created by Top1 on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "SignupViewController.h"
#import "PCUploadView.h"
#import "PCTextField.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"
#import "ApiManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserData.h"
#import "PHDataHelper.h"
#import "ApiConfig.h"

@interface SignupViewController () {
}

@property (weak, nonatomic) IBOutlet UITextField *mTxtPasswd;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPasswdRetype;
@property (weak, nonatomic) IBOutlet UITextField *mTxtEmail;

@property (weak, nonatomic) IBOutlet UIButton *mButSignup;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTextField:self.mTxtPasswd];
    [self initTextField:self.mTxtPasswdRetype];
    [self initTextField:self.mTxtEmail];
    
    // signup button
    [self initRoundButton:self.mButSignup];
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

- (IBAction)onButSignup:(id)sender {
    // check data validity
    if (self.mTxtName.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your name"];
        return;
    }
    if (self.mTxtUsername.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your username"];
        return;
    }
    if (self.mTxtPasswd.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your password"];
        return;
    }
    if (![self.mTxtPasswd.text isEqualToString:self.mTxtPasswdRetype.text]) {
        [PHUiHelper showAlertView:self message:@"Password does not match"];
        return;
    }
    if (self.mTxtEmail.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your email address"];
        return;
    }
    
    // get photo image
    UIImage *imgPhoto = [mviewPhotoCore getImage];
    NSData *dataPhoto;
    
    // convert it to data
    if (imgPhoto) {
        dataPhoto = UIImageJPEGRepresentation(imgPhoto, 1.0f);
    }
    
    NSString *strBirthday;
    if (mDateBirthday) {
        strBirthday = [PHDataHelper dateToString:mDateBirthday format:@"yyyy-MM-dd"];
    }
    
    //
    // call signup api
    //
    [[ApiManager sharedInstance] userSignupwithUsername:self.mTxtUsername.text
                                               password:self.mTxtPasswd.text
                                                   name:self.mTxtName.text
                                                  email:self.mTxtEmail.text
                                               birthday:strBirthday
                                                 gender:mnGender
                                                  photo:dataPhoto
                                                success:^(id response)
    {
        // hide progress view
        [SVProgressHUD dismiss];
        
        // set api token & current user
        [ApiManager sharedInstance].apiToken = [response valueForKey:@"api_token"];
        UserData *user = [[UserData alloc] initWidthDic:response];
        [UserData setCurrentUser:user];
        
        [self performSegueWithIdentifier:@"Signup2Main" sender:nil];
    }
                                                   fail:^(NSError *error, id response)
    {
        // hide progress view
        [SVProgressHUD dismiss];
        
        // close keyboard
        [self.view endEditing:YES];
        
        NSString *strDesc = [error localizedDescription];
        
        // sign up failed
        if ([ApiManager getStatusCode:error] == PH_FAIL_STATE) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSArray *aryKey = [response allKeys];
                NSArray *aryValue = [response valueForKey:aryKey[0]];
                strDesc = aryValue[0];
            }
        }
        
        [PHUiHelper showAlertView:self title:@"Signup Failed" message:strDesc];
    }];
    
    // show progress view
    [SVProgressHUD show];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.mTxtName) {
        [self.mTxtUsername becomeFirstResponder];
    }
    else if (textField == self.mTxtUsername) {
        [self.mTxtPasswd becomeFirstResponder];
    }
    else if (textField == self.mTxtPasswd) {
        [self.mTxtPasswdRetype becomeFirstResponder];
    }
    else if (textField == self.mTxtPasswdRetype) {
        [self.mTxtEmail becomeFirstResponder];
    }
    else if (textField == self.mTxtEmail) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


@end
