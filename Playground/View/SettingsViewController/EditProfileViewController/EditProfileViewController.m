//
//  EditProfileViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "EditProfileViewController.h"
#import "PCTextField.h"
#import "PCUploadView.h"
#import "PHTextHelper.h"

@interface EditProfileViewController () {
    int mnFontSize;
}

@property (weak, nonatomic) IBOutlet UIView *mViewPhoto;

@property (weak, nonatomic) IBOutlet PCTextField *mTxtName;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtUsername;

@property (weak, nonatomic) IBOutlet UILabel *mLblBirthCaption;
@property (weak, nonatomic) IBOutlet UILabel *mLblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *mLblGenderCaption;


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init parameter
    mnFontSize = 14;
    
    // add photo upload view
    PCUploadView *viewPhoto = [PCUploadView getView:UPLOAD_VIEW_RIGHT];
    viewPhoto.frame = self.mViewPhoto.bounds;
    [self.mViewPhoto addSubview:viewPhoto];
    
    // textfields
    [self initTextField:self.mTxtName];
    [self initTextField:self.mTxtUsername];
    
    // labels
    UIFont *fontBold = [PHTextHelper myriadProBold:mnFontSize];
    [self.mLblBirthCaption setFont:fontBold];
    [self.mLblBirthday setFont:fontBold];
    [self.mLblGenderCaption setFont:fontBold];
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
 Initialize text field
 @param textfield - text field to decorate
 */
- (void)initTextField:(UITextField *)textfield {
    // font
    [PHTextHelper initTextBold:textfield];
}


@end
