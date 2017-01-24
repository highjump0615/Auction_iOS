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
    
    if (textField == self.mTxtUsername) {
        [self.mTxtPassword becomeFirstResponder];
    }
    else if (textField == self.mTxtPassword) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


@end
