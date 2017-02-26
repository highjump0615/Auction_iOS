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

#import <SDWebImage/UIImageView+WebCache.h>

#import "UserData.h"
#import "ItemData.h"

#import "ApiManager.h"


@interface RateViewController () {
    PCRateView *mViewRateCore;
    ItemData *mItem;
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
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeLarge]]];
    [self.mLblUsername setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeSemiLarge]]];
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // photo
    [self.mImgviewUser.layer setBorderWidth:0.5];
    [self.mImgviewUser.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
    
    // button
    [self.mButRate.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // rate view
    mViewRateCore = [PCRateView getView];
    mViewRateCore.frame = self.mViewRate.bounds;
    [self.mViewRate addSubview:mViewRateCore];
    
    //
    // set contents
    //
    
    // user & item data
    [self.mImgviewUser sd_setImageWithURL:[NSURL URLWithString:[mItem.user photoUrl]]];
    [self.mLblUsername setText:mItem.username];
    [self.mLblItemname setText:mItem.title];
    
    // rate
    [mViewRateCore setRate:mItem.rate];
    
    // if already rated, no allowed to rate again
    if (mItem.rate > 0) {
        [self disableRateButton];
    }
}

/**
 disable rate button and rate view
 */
- (void)disableRateButton {
    [mViewRateCore setUserInteractionEnabled:NO];
    [self.mButRate setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [PHUiHelper makeRounded:self.mImgviewUser];
    [PHUiHelper makeRounded:self.mButRate];
}

- (void)setItemData:(id)item {
    mItem = item;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onButRate:(id)sender {
    //
    // call rate api
    //
    [[ApiManager sharedInstance] rateItemWithId:mItem.id
                                           rate:[mViewRateCore getRate]
                                           success:^(id response)
     {
     }
                                              fail:^(NSError *error, id response)
     {
     }];
    
    [mItem setRate:[mViewRateCore getRate]];
    [self disableRateButton];
}

@end
