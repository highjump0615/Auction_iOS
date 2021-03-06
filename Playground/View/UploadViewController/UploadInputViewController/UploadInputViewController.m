//
//  UploadInputViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UploadInputViewController.h"
#import "PlaceholderTextView.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PCRateView.h"
#import "PHUiHelper.h"
#import "CategoryData.h"
#import "UploadCategoryViewController.h"
#import "ActionSheetStringPicker.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ApiManager.h"
#import "UserData.h"
#import "ItemData.h"

@interface UploadInputViewController () {
    PCRateView *mViewRateCore;
    NSInteger mnTitleMaxLen;
    NSInteger mnDescMaxLen;
    int mnPeriod;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblLimit;

@property (weak, nonatomic) IBOutlet UITextField *mTxtTitle;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *mTxtDescription;
@property (weak, nonatomic) IBOutlet UITextField *mTxtCategory;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPrice;
@property (weak, nonatomic) IBOutlet UITextField *mTxtPeriod;

@property (weak, nonatomic) IBOutlet UILabel *mLblCondition;
@property (weak, nonatomic) IBOutlet UIView *mViewRate;

@property (weak, nonatomic) IBOutlet UILabel *mLblShare;

@property (weak, nonatomic) IBOutlet UIButton *mButAuction;

@end

@implementation UploadInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // input param
    mnTitleMaxLen = 30;
    mnDescMaxLen = 300;
    mnPeriod = 0;
    
    // upload label
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    
    // limit label
    [self.mLblLimit setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // title
    [PHTextHelper initTextRegular:self.mTxtTitle];
    
    // description
    [self.mTxtDescription setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mTxtDescription setPlaceholder:@"Description (up to 300 characters)"];
    [self.mTxtDescription setPlaceholderColor:[PHColorHelper colorTextGray]];
    
    // category
    [PHTextHelper initTextRegular:self.mTxtCategory];
    
    // price
    [PHTextHelper initTextRegular:self.mTxtPrice];
    
    // period
    [PHTextHelper initTextRegular:self.mTxtPeriod];
    
    // condition
    [self.mLblCondition setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    mViewRateCore = [PCRateView getView];
    mViewRateCore.frame = self.mViewRate.bounds;
    [mViewRateCore setRate:0];
    [self.mViewRate addSubview:mViewRateCore];
    
    // share
    [self.mLblShare setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // auction button
    [self.mButAuction.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [PHUiHelper makeRounded:self.mButAuction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set category
    if (self.mCategory) {
        [self.mTxtCategory setText:self.mCategory.name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getDayString:(int)day {
    NSString *strDay = [NSString stringWithFormat:@"%d Day", day + 1];
    
    // if more than 1, make it plural form
    if (day > 0) {
        strDay = [strDay stringByAppendingString:@"s"];
    }
    
    return strDay;
}

- (IBAction)onButAuction:(id)sender {
    // check data validity
    if (self.mTxtTitle.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input the title"];
        return;
    }
    if (self.mTxtDescription.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input descritption"];
        return;
    }
    if (!self.mCategory) {
        [PHUiHelper showAlertView:self message:@"Select category"];
    }
    if (self.mTxtPrice.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input price"];
        return;
    }
    if (mnPeriod == 0) {
        [PHUiHelper showAlertView:self message:@"Select period"];
        return;
    }
    
    // get images
    NSData *dataImage0, *dataImage1, *dataImage2, *dataImage3;
    if (self.mImgCover) {
        dataImage0 = UIImageJPEGRepresentation(self.mImgCover, 1.0f);
    }
    if (self.mImgPreview1) {
        dataImage1 = UIImageJPEGRepresentation(self.mImgPreview1, 1.0f);
    }
    if (self.mImgCover) {
        dataImage2 = UIImageJPEGRepresentation(self.mImgPreview2, 1.0f);
    }
    if (self.mImgCover) {
        dataImage3 = UIImageJPEGRepresentation(self.mImgPreview3, 1.0f);
    }
        
    //
    // call upload item api
    //
    [[ApiManager sharedInstance] uploadItemWithTitle:self.mTxtTitle.text
                                         description:self.mTxtDescription.text
                                            category:self.mCategory.id
                                               price:self.mTxtPrice.text
                                           condition:[mViewRateCore getRate]
                                              period:mnPeriod
                                              image0:dataImage0
                                              image1:dataImage1
                                              image2:dataImage2
                                              image3:dataImage3
                                             success:^(id response)
     {
         // hide progress view
         [SVProgressHUD dismiss];
         
         ItemData *itemNew = [[ItemData alloc] initWithDic:response];
         
         // add to current user item list
         UserData *user = [UserData currentUser];
         [user.auctionItems addObject:itemNew];

         // back to previous page
         NSArray *array = [self.navigationController viewControllers];
         [self.navigationController popToViewController:array[array.count-3 ] animated:YES];
     }
                                                fail:^(NSError *error, id response)
     {
         // hide progress view
         [SVProgressHUD dismiss];
         
         // close keyboard
         [self.view endEditing:YES];
         
         NSString *strDesc = [error localizedDescription];
         
         [PHUiHelper showAlertView:self title:@"Upload failed" message:strDesc];
     }];
    
    // show progress view
    [SVProgressHUD show];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"Upload2Category"]) {
        UploadCategoryViewController *viewController = [segue destinationViewController];
        viewController.delegate = self;
    }
}

#pragma mark - Actionsheet selector

- (void)OnSelect:(NSNumber *)selectedIndex element:(id)element {
    mnPeriod = [selectedIndex intValue];
    [self.mTxtPeriod setText:[self getDayString:mnPeriod]];
}

- (void)OnCancel:(id)sender {
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.mTxtPeriod]) {
        
        // close keyboard first
        [self.view endEditing:YES];
        
        //
        // show picker
        //
        NSMutableArray *aryPeriod = [[NSMutableArray alloc] init];
        for (int i = 0; i < 7; i++) {
            [aryPeriod addObject:[self getDayString:i]];
        }
        
        [ActionSheetStringPicker showPickerWithTitle:@"Choose Period"
                                                rows:aryPeriod
                                    initialSelection:mnPeriod
                                              target:self
                                       successAction:@selector(OnSelect:element:)
                                        cancelAction:@selector(OnCancel:)
                                              origin:textField];
        
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.mTxtTitle]) {
        // show limit number
        [self.mLblLimit setHidden:NO];
        
        // update limit
        [self.mLblLimit setText:[NSString stringWithFormat:@"%ld/%ld", (long)(mnTitleMaxLen - textField.text.length), (long)mnTitleMaxLen]];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // hide limit number
    [self.mLblLimit setHidden:YES];

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.mTxtTitle]) {
        [self.mTxtDescription becomeFirstResponder];
    }
    
    return NO;
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // only consider title text field
    if (textField != self.mTxtTitle) {
        return YES;
    }
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    if (newLength <= mnTitleMaxLen) {
        [self.mLblLimit setText:[NSString stringWithFormat:@"%ld/%ld", (long)(mnTitleMaxLen - newLength), (long)mnTitleMaxLen]];
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    BOOL bRes = NO;
    
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [text length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    if (newLength <= mnDescMaxLen) {
        [self.mLblLimit setText:[NSString stringWithFormat:@"%ld/%ld", (long)(mnDescMaxLen - newLength), (long)mnDescMaxLen]];
        bRes = YES;
    }

    return bRes;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    // show limit number
    [self.mLblLimit setHidden:NO];
    
    // update limit
    [self.mLblLimit setText:[NSString stringWithFormat:@"%ld/%ld", (long)(mnDescMaxLen - textView.text.length), (long)mnDescMaxLen]];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    // hide limit number
    [self.mLblLimit setHidden:YES];

    return YES;
}


@end
