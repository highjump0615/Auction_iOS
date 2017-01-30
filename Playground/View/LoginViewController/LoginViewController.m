//
//  LoginViewController.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "LoginViewController.h"
#import "PCTextField.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"
#import "ApiManager.h"
#import "ApiConfig.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserData.h"
#import "MainTabbarController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet PCTextField *mTxtUsername;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtPassword;

@property (weak, nonatomic) IBOutlet UIButton *mButLogin;
@property (weak, nonatomic) IBOutlet UIButton *mButFacebook;
@property (weak, nonatomic) IBOutlet UIButton *mButForget;
@property (weak, nonatomic) IBOutlet UIButton *mButSignup;

@property (weak, nonatomic) IBOutlet UILabel *mLblOr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstBottomMargin;

@end

@implementation LoginViewController

/**
 Initialize text field
 @param textfield - text field to decorate
 */
- (void)initTextField:(UITextField *)textfield {
    
    [PHUiHelper setPurpleBorder:textfield cornerRadius:10];
    
    // font
    [PHTextHelper initTextBold:textfield];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // init appearance of the controls
    //
    UIFont *fontRegular = [PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]];
    
    // textfields
    [self initTextField:self.mTxtUsername];
    [self initTextField:self.mTxtPassword];
    
    // signin button
    [self initLoginButton:self.mButLogin];
    
    // facebook button
    [self initLoginButton:self.mButFacebook];
    
    // or label
    [self.mLblOr setFont:fontRegular];

    // other buttons
    [self.mButForget.titleLabel setFont:fontRegular];
    [self.mButSignup.titleLabel setFont:fontRegular];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    // bottom margin
    if ([PHUiHelper deviceType] == PHDevice_iPhone5) {
        [self.mCstBottomMargin setConstant:30];
    }
    
    // if logged in, go to main page directly
    UserData *currentUser = [UserData currentUser];
    if (currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainTabbarController *tbc = (MainTabbarController *)[storyboard instantiateViewControllerWithIdentifier:@"MainTabbar"];
        [self.navigationController pushViewController:tbc animated:NO];
        
        // load api token
        [[ApiManager sharedInstance] loadApiToken];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // clear credentials input
    [self.mTxtUsername setText:@""];
    [self.mTxtPassword setText:@""];    
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onButLogin:(id)sender {
   
    // check data validity
    if (self.mTxtUsername.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your username"];
        return;
    }
    if (self.mTxtPassword.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your password"];
        return;
    }
    
    //
    // call login api
    //
    [[ApiManager sharedInstance] userSigninwithUsername:self.mTxtUsername.text
                                               password:self.mTxtPassword.text
                                                success:^(id response)
    
    {
        // hide progress view
        [SVProgressHUD dismiss];
        
        // set api token & current user
        [ApiManager sharedInstance].apiToken = [response valueForKey:@"api_token"];
        UserData *user = [[UserData alloc] initWithDic:response];
        [UserData setCurrentUser:user];
        
        [self performSegueWithIdentifier:@"Login2Main" sender:nil];
    }
                                                   fail:^(NSError *error, id response)
    {
        // hide progress view
        [SVProgressHUD dismiss];
        
        // close keyboard
        [self.view endEditing:YES];
        
        NSString *strDesc = [error localizedDescription];
        
        // log in failed
        if ([ApiManager getStatusCode:error] == PH_FAIL_STATE) {
            strDesc = @"Username or password does not match";
        }
        
        [PHUiHelper showAlertView:self title:@"Login Failed" message:strDesc];
    }];
    
    // show progress view
    [SVProgressHUD show];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.mTxtUsername) {
        [self.mTxtPassword becomeFirstResponder];
    }
    else if (textField == self.mTxtPassword) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


@end
