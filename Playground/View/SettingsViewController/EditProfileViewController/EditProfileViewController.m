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
#import "PHColorHelper.h"
#import "ActionSheetDatePicker.h"
#import "TTTAttributedLabel.h"
#import "UserData.h"
#import "PHDataHelper.h"
#import "ApiManager.h"
#import "ApiConfig.h"
#import "PHUiHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define GENDER_UNKNOWN          1
#define GENDER_FEMALE           2
#define GENDER_MALE             3

#define STR_GENDER_UNKNOWN      @"Decline to state"
#define STR_GENDER_FEMALE       @"Female"
#define STR_GENDER_MALE         @"Male"

#define kGenderKey              @"gender"

@interface EditProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    NSInteger mnFontSize;
    NSDateFormatter *mDateFormat;
}

@property (weak, nonatomic) IBOutlet UIView *mViewPhoto;

@property (weak, nonatomic) IBOutlet UILabel *mLblBirthCaption;
@property (weak, nonatomic) IBOutlet UILabel *mLblBirthday;

@property (weak, nonatomic) IBOutlet UILabel *mLblGenderCaption;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *mLblGender;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init parameter
    mnFontSize = [PHTextHelper fontSizeNormal];
    
    mDateFormat = [[NSDateFormatter alloc] init];
    [mDateFormat setDateFormat:@"dd / MM / yyyy"];
    
    // add photo upload view
    mviewPhotoCore = [PCUploadView getView:UPLOAD_VIEW_RIGHT controller:self];
    mviewPhotoCore.frame = self.mViewPhoto.bounds;
    [self.mViewPhoto addSubview:mviewPhotoCore];
    
    // textfields
    [self initTextField:self.mTxtName];
    [self initTextField:self.mTxtUsername];
    
    // labels
    UIFont *fontBold = [PHTextHelper myriadProBold:mnFontSize];
    [self.mLblBirthCaption setFont:fontBold];
    [self.mLblBirthday setFont:fontBold];
    [self.mLblGenderCaption setFont:fontBold];
    
    //
    // init gender string
    //
    [self.mLblGender setLinkAttributes:nil];
    [self updateGenderLabel:0];
    
    //
    // add linke for selecting gender
    //
    NSString *strText = [NSString stringWithFormat:@"%@ / %@ / %@", STR_GENDER_FEMALE, STR_GENDER_MALE, STR_GENDER_UNKNOWN];
    
    // add female link
    NSDictionary *dicGender = @{kGenderKey : [NSNumber numberWithInt:GENDER_FEMALE]};
    NSRange range = [strText rangeOfString:STR_GENDER_FEMALE];
    [self.mLblGender addLinkToTransitInformation:dicGender withRange:range];
    
    // add male link
    dicGender = @{kGenderKey : [NSNumber numberWithInt:GENDER_MALE]};
    range = [strText rangeOfString:STR_GENDER_MALE];
    [self.mLblGender addLinkToTransitInformation:dicGender withRange:range];
    
    // add male link
    dicGender = @{kGenderKey : [NSNumber numberWithInt:GENDER_UNKNOWN]};
    range = [strText rangeOfString:STR_GENDER_UNKNOWN];
    [self.mLblGender addLinkToTransitInformation:dicGender withRange:range];
    
    //
    // set content
    //
    UserData *user = [UserData currentUser];
    
    if (user) {
        // photo
        [mviewPhotoCore setImage:nil fromUrl:[user photoUrl]];
        
        // name
        [self.mTxtName setText:user.name];
        
        // username
        [self.mTxtUsername setText:user.username];
        
        // birthday
        if (user.birthday) {
            mDateBirthday = user.birthday;
            [self.mLblBirthday setText:[PHDataHelper dateToString:user.birthday format:@"dd / MM / yyyy"]];
        }
        
        // gender
        mnGender = user.gender;
        [self updateGenderLabel:user.gender];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 update gender label according to the selected gender
 @param gender <#gender description#>
 */
- (void)updateGenderLabel:(NSInteger)gender {
    NSDictionary *dicAttribSelected = @{NSFontAttributeName:[PHTextHelper myriadProBold:mnFontSize],
                                        NSForegroundColorAttributeName:[PHColorHelper colorTextBlack]};
    NSDictionary *dicAttribNormal = @{NSFontAttributeName:[PHTextHelper myriadProBold:mnFontSize],
                                      NSForegroundColorAttributeName:[PHColorHelper colorTextGray]};
    
    NSMutableAttributedString *strGender = [[NSMutableAttributedString alloc] init];
    NSAttributedString *strTemp;
    NSDictionary *dicString;
    
    // add female
    dicString = dicAttribNormal;
    if (gender == GENDER_FEMALE) {
        dicString = dicAttribSelected;
    }
    strTemp = [[NSAttributedString alloc] initWithString:STR_GENDER_FEMALE attributes:dicString];
    [strGender appendAttributedString:strTemp];
    
    // add slash
    strTemp = [[NSAttributedString alloc] initWithString:@" / " attributes:dicAttribNormal];
    [strGender appendAttributedString:strTemp];
    
    // add male
    dicString = dicAttribNormal;
    if (gender == GENDER_MALE) {
        dicString = dicAttribSelected;
    }
    strTemp = [[NSAttributedString alloc] initWithString:STR_GENDER_MALE attributes:dicString];
    [strGender appendAttributedString:strTemp];
    
    // add slash
    strTemp = [[NSAttributedString alloc] initWithString:@" / " attributes:dicAttribNormal];
    [strGender appendAttributedString:strTemp];
    
    // add unknown
    dicString = dicAttribNormal;
    if (gender == GENDER_UNKNOWN) {
        dicString = dicAttribSelected;
    }
    strTemp = [[NSAttributedString alloc] initWithString:STR_GENDER_UNKNOWN attributes:dicString];
    [strGender appendAttributedString:strTemp];
    
    [self.mLblGender setAttributedText:strGender];
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

- (IBAction)onButBirthday:(id)sender {
    // string to date
    NSDate *date = mDateBirthday;
    
    // today as default
    if (!date) {
        date = [[NSDate alloc] init];
    }
    
    ActionSheetDatePicker *actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select birthday"
                                                                             datePickerMode:UIDatePickerModeDate
                                                                               selectedDate:date
                                                                                     target:self
                                                                                     action:@selector(dateWasSelected:element:)
                                                                                     origin:sender];
    
    [actionSheetPicker showActionSheetPicker];
}

/**
 called when date is selected from the picker
 @param selectedDate <#selectedDate description#>
 @param element <#element description#>
 */
- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    // date to string
    NSString *strDate = [mDateFormat stringFromDate:selectedDate];
    mDateBirthday = selectedDate;
    
    [self.mLblBirthday setText:strDate];
    
    // change color
    [self.mLblBirthday setTextColor:[PHColorHelper colorTextBlack]];
}

/**
 get image data from photo
 @return <#return value description#>
 */
- (NSData *)getImageData {
    // get photo image
    UIImage *imgPhoto = [mviewPhotoCore getImage];
    NSData *dataPhoto;
    
    // convert it to data
    if (imgPhoto) {
        dataPhoto = UIImageJPEGRepresentation(imgPhoto, 1.0f);
    }
    
    return dataPhoto;
}

/**
 back to prev page
 @param sender sender description
 */
- (void)onButBack:(id)sender {
    
    UserData *user = [UserData currentUser];
    
    // sign up page, go back
    if (!user) {
        [super onButBack:sender];
        return;
    }
    
    // ------ Edit profile, save
    
    // check data validity
    if (self.mTxtName.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your name"];
        return;
    }
    if (self.mTxtUsername.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your username"];
        return;
    }
    
    // save profile
    [[ApiManager sharedInstance] saveProfilewithUsername:self.mTxtUsername.text
                                                    name:self.mTxtName.text
                                                birthday:[PHDataHelper dateToString:mDateBirthday format:@"yyyy-MM-dd"]
                                                  gender:mnGender
                                                   photo:[self getImageData]
                                                 success:^(id response)
     {
         // hide progress view
         [SVProgressHUD dismiss];
         
         [user updateProfile:response];
         [UserData setCurrentUser:user];
         
         [super onButBack:sender];
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
         
         [PHUiHelper showAlertView:self title:@"Update Failed" message:strDesc];
     }];
    
    // show progress view
    [SVProgressHUD show];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    
    return YES;
}

#pragma mark - TTTAttributedLabelDelegate

/**
 called when clicked
 @param label <#label description#>
 @param components <#components description#>
 */
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    mnGender = [components[kGenderKey] integerValue];
    [self updateGenderLabel:mnGender];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imgRes = [info objectForKey:UIImagePickerControllerEditedImage];
    [mviewPhotoCore setImage:imgRes fromUrl:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
