//
//  AuctionViewController.m
//  Playground
//
//  Created by Top1 on 1/17/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "AuctionViewController.h"
#import "PHColorHelper.h"
#import "PHTextHelper.h"
#import "PCItemView.h"
#import "PCNoticeTimeout.h"
#import "PCNoticePrice.h"
#import "PHUiHelper.h"
#import "PCAlertDialog.h"

@interface AuctionViewController () {
    PCItemView *mViewItemCore1;
    PCItemView *mViewItemCore2;
    PCItemView *mViewItemCore3;
    
    PCNoticeTimeout *mViewTimeoutCore;
    PCNoticePrice *mViewAuctionCore;
    PCNoticePrice *mViewBidCore;
}

@property (weak, nonatomic) IBOutlet UIImageView *mImgviewItem;
@property (weak, nonatomic) IBOutlet UILabel *mLblItemname;

@property (weak, nonatomic) IBOutlet UIView *mViewItem1;
@property (weak, nonatomic) IBOutlet UIView *mViewItem2;
@property (weak, nonatomic) IBOutlet UIView *mViewItem3;

@property (weak, nonatomic) IBOutlet UIView *mViewTimeout;
@property (weak, nonatomic) IBOutlet UIView *mViewAuction;
@property (weak, nonatomic) IBOutlet UIView *mViewBid;

@property (weak, nonatomic) IBOutlet UIButton *mButGiveup;
@property (weak, nonatomic) IBOutlet UIButton *mButContact;
@property (weak, nonatomic) IBOutlet UIButton *mButDelete;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstTimeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstPriceHeight;

@end

@implementation AuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nav bar
    [self showNavbarCongrat:YES];
    
    // item view
    [self.mImgviewItem.layer setBorderWidth:0.5f];
    [self.mImgviewItem.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
    [PHUiHelper makeRounded:self.mImgviewItem];
    
    // font
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButGiveup.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButContact.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButDelete.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    //
    // add item view
    //
    mViewItemCore1 = [PCItemView getView];
    mViewItemCore1.frame = self.mViewItem1.bounds;
    [self.mViewItem1 addSubview:mViewItemCore1];
    
    mViewItemCore2 = [PCItemView getView];
    mViewItemCore2.frame = self.mViewItem2.bounds;
    [self.mViewItem2 addSubview:mViewItemCore2];
    
    mViewItemCore3 = [PCItemView getView];
    mViewItemCore3.frame = self.mViewItem3.bounds;
    [self.mViewItem3 addSubview:mViewItemCore3];
    
    //
    // add timeout view
    //
    mViewTimeoutCore = [PCNoticeTimeout getView];
    
    // Set the width of the cell to match the width of the container view
    mViewTimeoutCore.frame = self.mViewTimeout.bounds;
    [mViewTimeoutCore setValueText:@"24H 00M"];
    [self.mViewTimeout addSubview:mViewTimeoutCore];
    
    //
    // add auction view
    //
    mViewAuctionCore = [PCNoticePrice getView];
    mViewAuctionCore.frame = self.mViewAuction.bounds;
    [self.mViewAuction addSubview:mViewAuctionCore];
    
    //
    // add bid view
    //
    mViewBidCore = [PCNoticePrice getView];
    mViewBidCore.frame = self.mViewBid.bounds;
    [mViewBidCore setTitle:@"Highest Bid"];
    [mViewBidCore setValueText:@"$220"];
    [mViewBidCore setBackgroundImage:[PHUiHelper redBackground]];
    
    [self.mViewBid addSubview:mViewBidCore];
    
    // give up button
    [self.mButGiveup.layer setBorderWidth:1.0];
    [self.mButGiveup.layer setBorderColor:[PHColorHelper colorTextBlack].CGColor];
    [PHUiHelper makeRounded:self.mButGiveup];
    
    // contact button
    [PHUiHelper makeRounded:self.mButContact];
    
    // delete button
    [PHUiHelper makeRounded:self.mButDelete];
    
    // margin
    if ([PHUiHelper deviceType] == PHDevice_iPhone5) {
        [self.mCstTimeHeight setConstant:99];
        [self.mCstPriceHeight setConstant:80];
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

- (IBAction)onButGiveup:(id)sender {
    PCAlertDialog *viewAlert = [PCAlertDialog getView];
    viewAlert.frame = self.view.bounds;
    [self.view addSubview:viewAlert];
    
    [viewAlert showView:YES animated:YES];
}

- (IBAction)onButContact:(id)sender {
}

- (IBAction)onButDelete:(id)sender {
}

@end
