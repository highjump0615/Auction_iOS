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

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet PCTextField *mTxtUsername;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtPassword;

@property (weak, nonatomic) IBOutlet UIButton *mButLogin;
@property (weak, nonatomic) IBOutlet UIButton *mButFacebook;
@property (weak, nonatomic) IBOutlet UIButton *mButForget;
@property (weak, nonatomic) IBOutlet UIButton *mButSignup;

@property (weak, nonatomic) IBOutlet UILabel *mLblOr;

@end

@implementation LoginViewController

/**
 Initialize text field
 @param textfield - text field to decorate
 */
- (void)initTextField:(UITextField *)textfield {
    
    int nRadius = 10;
    
    // make border
    [textfield.layer setMasksToBounds:YES];
    [textfield.layer setBorderColor:[UIColor colorWithRed:122/255.0
                                                    green:167/255.0
                                                     blue:244/255.0
                                                    alpha:1.0].CGColor];
    [textfield.layer setBorderWidth:1.0f];
    
    [textfield.layer setCornerRadius:nRadius];
    
    // font
    UIFont *fontBold = [PHTextHelper myriadProBold:14];
    [textfield setFont:fontBold];
    
    // placeholder
    UIColor *colorGray = [PHColorHelper colorTextGray];
    if ([textfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textfield.placeholder
                                                                          attributes:@{NSForegroundColorAttributeName:colorGray}];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // init appearance of the controls
    //
    UIFont *fontRegular = [PHTextHelper myriadProRegular:14];
    
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

#pragma mark - TextField

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
