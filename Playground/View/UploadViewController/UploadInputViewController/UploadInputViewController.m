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

@interface UploadInputViewController () {
    PCRateView *mViewRateCore;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;

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
    
    // upload label
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    
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
    [self.mViewRate addSubview:mViewRateCore];
    
    // share
    [self.mLblShare setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // auction button
    [self.mButAuction.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.mTxtTitle) {
        [self.mTxtDescription becomeFirstResponder];
    }
    
    return NO;
}


@end
