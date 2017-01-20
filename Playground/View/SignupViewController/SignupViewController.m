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

@interface SignupViewController () {
}

@property (weak, nonatomic) IBOutlet PCTextField *mTxtPasswd;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtPasswdRetype;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtEmail;

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
