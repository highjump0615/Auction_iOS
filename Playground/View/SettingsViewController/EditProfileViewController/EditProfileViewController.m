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

#define GENDER_UNKNOWN          1
#define GENDER_FEMALE           2
#define GENDER_MALE             3

#define STR_GENDER_UNKNOWN      @"Decline to state"
#define STR_GENDER_FEMALE       @"Female"
#define STR_GENDER_MALE         @"Male"

#define kGenderKey              @"gender"

@interface EditProfileViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    int mnFontSize;
    NSDateFormatter *mDateFormat;
    NSDate *mDateBirthday;
    
    PCUploadView *viewPhotoCore;
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
    mnFontSize = 14;
    
    mDateFormat = [[NSDateFormatter alloc] init];
    [mDateFormat setDateFormat:@"dd / MM / yyyy"];
    
    // add photo upload view
    viewPhotoCore = [PCUploadView getView:UPLOAD_VIEW_RIGHT controller:self];
    viewPhotoCore.frame = self.mViewPhoto.bounds;
    [self.mViewPhoto addSubview:viewPhotoCore];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 update gender label according to the selected gender
 @param gender <#gender description#>
 */
- (void)updateGenderLabel:(int)gender {
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - TTTAttributedLabelDelegate

/**
 called when clicked
 @param label <#label description#>
 @param components <#components description#>
 */
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    int nGender = [components[kGenderKey] intValue];
    [self updateGenderLabel:nGender];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imgRes = [info objectForKey:UIImagePickerControllerEditedImage];
    [viewPhotoCore setImage:imgRes];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
