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

#import <SDWebImage/UIImageView+WebCache.h>

#import "UserData.h"
#import "ItemData.h"


@interface AuctionViewController () {
    NSMutableArray *maryViewItemCore;
    
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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstItemWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstItemHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstMarginBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstTimeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstPriceHeight;

// constraint for showing 1, 2 or 3 users
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstUserHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstWidth1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstSpacing1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstWidth2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstSpacing2;

@end

@implementation AuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // item view
    [self.mImgviewItem.layer setBorderWidth:0.5f];
    [self.mImgviewItem.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
    
    // font
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButGiveup.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButContact.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mButDelete.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    //
    // add user view
    //
    maryViewItemCore = [[NSMutableArray alloc] init];
    
    PCItemView *viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem1.bounds;
    [self.mViewItem1 addSubview:viewItemCore];
    [maryViewItemCore addObject:viewItemCore];
    
    viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem2.bounds;
    [self.mViewItem2 addSubview:viewItemCore];
    [maryViewItemCore addObject:viewItemCore];
    
    viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem3.bounds;
    [self.mViewItem3 addSubview:viewItemCore];
    [maryViewItemCore addObject:viewItemCore];
    
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
    
    // different dimension on 4 inch
    if ([PHUiHelper deviceType] == PHDevice_iPhone5) {
        // notice height
        [self.mCstTimeHeight setConstant:95];
        [self.mCstPriceHeight setConstant:75];
        
        // margin
        [self.mCstMarginTop setConstant:10];
        [self.mCstMarginBottom setConstant:10];
        
        // item size
        [self.mCstItemWidth setConstant:89];
        [self.mCstItemHeight setConstant:89];
    }
    
    //
    // set contents
    //
    UserData *user = [UserData currentUser];
    ItemData *item = (ItemData *)self.mItemData;
    
    // nav bar
    if ([item getUserRank:user] >= 0) {
        // top 3, congratulations
        [self showNavbarCongrat:YES];
    }
    else {
        // auction closed
        [self setTitle:@"Auction Closed"];
        [self showTitle:YES];
    }
    
    // item data
    [self.mImgviewItem sd_setImageWithURL:[NSURL URLWithString:[item getCoverImageUrl]]];
    [self.mLblItemname setText:item.title];
    
    // top bid users
    for (int i = 0; i < item.bids.count; i++) {
        PCItemView *userView = [maryViewItemCore objectAtIndex:i];
        [userView setUserData:user item:item];
    }
    
    // hide users if bidders are less than 3
    if (item.bids.count < 3) {
        [self.mCstWidth2 setPriority:UILayoutPriorityRequired];
        [self.mCstSpacing2 setPriority:UILayoutPriorityRequired];
        [maryViewItemCore[2] setHidden:YES];
    }
    if (item.bids.count < 2) {
        [self.mCstWidth1 setPriority:UILayoutPriorityRequired];
        [self.mCstSpacing1 setPriority:UILayoutPriorityRequired];
        [maryViewItemCore[1] setHidden:YES];
    }
    if (item.bids.count < 1) {
        [self.mCstUserHeight setConstant:0];
        [maryViewItemCore[0] setHidden:YES];
    }
    
    // timeout & price
    if ([item getUserRank:user] < 0) {
        // not in top 3, hide timeout view
        [self.mCstTimeHeight setConstant:0];
        [self.mViewTimeout setHidden:YES];
    }

    [mViewAuctionCore setValueText:[NSString stringWithFormat:@"$%ld", (long)item.price]];
    [mViewBidCore setValueText:[NSString stringWithFormat:@"$%ld", (long)[item getMaxBidPrice]]];
    
    // buttons
    if ([item getUserRank:user] != 0) {
        // not top 1, delete only
        [self.mButDelete setHidden:NO];
        [self.mButGiveup setHidden:YES];
        [self.mButContact setHidden:YES];
    }
}

- (void)viewDidLayoutSubviews {
    // make item view round after layout is determined
    [PHUiHelper makeRounded:self.mImgviewItem];
    
    [PHUiHelper makeRounded:self.mButGiveup];
    
    // contact button
    [PHUiHelper makeRounded:self.mButContact];
    
    // delete button
    [PHUiHelper makeRounded:self.mButDelete];
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
