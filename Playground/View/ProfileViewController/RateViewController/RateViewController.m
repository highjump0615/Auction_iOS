//
//  RateViewController.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "RateViewController.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"
#import "PCRateView.h"

@interface RateViewController () {
    PCRateView *mViewRateCore;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mImgviewUser;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;
@property (weak, nonatomic) IBOutlet UILabel *mLblItemname;
@property (weak, nonatomic) IBOutlet UIView *mViewRate;
@property (weak, nonatomic) IBOutlet UIButton *mButRate;

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // label
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:32]];
    [self.mLblUsername setFont:[PHTextHelper myriadProBold:26]];
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:14]];
    
    // photo
    [PHUiHelper makeRounded:self.mImgviewUser];
    [self.mImgviewUser.layer setBorderWidth:0.5];
    [self.mImgviewUser.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
    
    // button
    [PHUiHelper makeRounded:self.mButRate];
    [self.mButRate.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
    
    // rate view
    mViewRateCore = [PCRateView getView];
    mViewRateCore.frame = self.mViewRate.bounds;
    [self.mViewRate addSubview:mViewRateCore];
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

@end
