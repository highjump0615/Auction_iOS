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
#import "ApiManager.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "UserData.h"
#import "ItemData.h"
#import "BidData.h"


@interface AuctionViewController () <PCItemViewDelegate, PCAlertDialogDelegate> {
    NSMutableArray *maryViewItemCore;
    
    PCNoticeTimeout *mViewTimeoutCore;
    PCNoticePrice *mViewAuctionCore;
    PCNoticePrice *mViewBidCore;
    
    NSTimer *mTimerItem;
    PCAlertDialog *mviewAlert;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstWidthEqual1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstSpacing1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstWidth2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstWidthEqual2;
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
    
    mviewAlert = [PCAlertDialog getView];
    mviewAlert.frame = self.view.bounds;
    mviewAlert.delegate = self;
    [self.view addSubview:mviewAlert];
    
    //
    // add user view
    //
    maryViewItemCore = [[NSMutableArray alloc] init];
    
    PCItemView *viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem1.bounds;
    viewItemCore.delegate = self;
    [self.mViewItem1 addSubview:viewItemCore];
    [maryViewItemCore addObject:viewItemCore];
    
    viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem2.bounds;
    viewItemCore.delegate = self;
    [self.mViewItem2 addSubview:viewItemCore];
    [maryViewItemCore addObject:viewItemCore];
    
    viewItemCore = [PCItemView getView];
    viewItemCore.frame = self.mViewItem3.bounds;
    viewItemCore.delegate = self;
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
        BidData *bData = [item.bids objectAtIndex:i];
        [userView setUserData:bData.userId item:item];
    }
    
    // hide users if bidders are less than 3
    if (item.bids.count < 3) {
        [self.mCstWidth2 setPriority:UILayoutPriorityRequired];
        [self.mCstSpacing2 setPriority:UILayoutPriorityRequired];
        [self.mCstWidthEqual2 setPriority:UILayoutPriorityDefaultHigh];
        [maryViewItemCore[2] setHidden:YES];
    }
    if (item.bids.count < 2) {
        [self.mCstWidth1 setPriority:UILayoutPriorityRequired];
        [self.mCstSpacing1 setPriority:UILayoutPriorityRequired];
        [self.mCstWidthEqual1 setPriority:UILayoutPriorityDefaultHigh];
        [maryViewItemCore[1] setHidden:YES];
    }
    if (item.bids.count < 1) {
        [self.mCstUserHeight setConstant:0];
        [maryViewItemCore[0] setHidden:YES];
    }
    
    //
    // timeout
    //
    // 1. item is not mine and I am not in top 3
    // 2. I was in top 1, but gave up
    if ([item getUserRank:user] < 0 && ![item isMine]) {
        
        // not in top 3, hide timeout view
        [self hideTimeOut];
    }
    
    [self updateTimeout];

    // price
    [mViewAuctionCore setValueText:[NSString stringWithFormat:@"$%ld", (long)item.price]];
    [mViewBidCore setValueText:[NSString stringWithFormat:@"$%ld", (long)[item getMaxBidPrice]]];
    
    // buttons
    [self updateButtonToPending];
    
    if ([item isMine]) {
        [self.mButGiveup setEnabled:NO];
    }
    // 1. I am not top 1
    // 2. I was in top 1, but gave up
    else if ([item getUserRank:user] != 0) {
        // not top 1, delete only
        [self showDeleteButton];
    }
}

- (void)viewDidLayoutSubviews {
    // make item view round after layout is determined
    [super viewDidLayoutSubviews];
    
    [PHUiHelper makeRounded:self.mImgviewItem];
    
    [PHUiHelper makeRounded:self.mButGiveup];
    
    // contact button
    [PHUiHelper makeRounded:self.mButContact];
    
    // delete button
    [PHUiHelper makeRounded:self.mButDelete];
}

- (void)showDeleteButton {
    [self.mButDelete setHidden:NO];
    [self.mButGiveup setHidden:YES];
    [self.mButContact setHidden:YES];
}

- (void)hideTimeOut {
    [self.mCstTimeHeight setConstant:0];
    [self.mViewTimeout setHidden:YES];
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

- (void)updateTimeout {
    UserData *user = [UserData currentUser];
    ItemData *item = (ItemData *)self.mItemData;
    
    // top 1
    if ([item getUserRank:user] == 0 || [item isMine]) {
        [mViewTimeoutCore setTitle:@"Time Remaining"];
        [mViewTimeoutCore setValueText:[item remainAuctionTimeLong:24*60]];
    }
    // top 2
    else if ([item getUserRank:user] == 1) {
        [mViewTimeoutCore setTitle:@"Available in"];
        [mViewTimeoutCore setValueText:[item remainAuctionTimeLong:24*60]];
    }
    // top 3
    else if ([item getUserRank:user] == 2) {
        [mViewTimeoutCore setTitle:@"Available in"];
        [mViewTimeoutCore setValueText:[item remainAuctionTimeLong:48*60]];
    }
}

- (void)viewDidAppear:(BOOL)animated {    
    //
    // timer for updating timeout
    //
    mTimerItem = [NSTimer scheduledTimerWithTimeInterval:30
                                                  target:self
                                                selector:@selector(updateItem:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    // stop timer
    [mTimerItem invalidate];
}

- (void)updateItem:(id)sender {
    // timeout
    [self updateTimeout];
}

- (IBAction)onButGiveup:(id)sender {
    [mviewAlert showView:YES animated:YES];
}

/**
 make contact button pending
 */
- (void)updateButtonToPending {
    ItemData *item = (ItemData *)self.mItemData;
    UserData *user = [UserData currentUser];
    
    // already contacted
    // or received contact request
    if (item.contact == user.id || item.contact > 0) {
        [self.mButContact setTitle:@"Pending..." forState:UIControlStateNormal];
        [self.mButContact setEnabled:NO];
    }
    // already contacted and accepted
    else if (item.contact < 0) {
        [self.mButContact setTitle:@"Contacted" forState:UIControlStateNormal];
        [self.mButContact setEnabled:NO];
    }
}

- (IBAction)onButContact:(id)sender {
    ItemData *item = (ItemData *)self.mItemData;
    
    // call contact api
    [[ApiManager sharedInstance] contactItemWithId:item.id
                                           success:^(id response)
     {
         item.contact = [[response valueForKey:@"contact"] integerValue];
         [self updateButtonToPending];
     }
                                              fail:^(NSError *error, id response)
     {
         [PHUiHelper showAlertView:self title:@"Contact Failed" message:[ApiManager getErrorDescription:error response:response]];
         
         [self.mButContact setEnabled:YES];
     }];

    [self.mButContact setEnabled:NO];
}

- (IBAction)onButDelete:(id)sender {
    ItemData *item = (ItemData *)self.mItemData;
    
    // call delete api
    [[ApiManager sharedInstance] deleteBidWithItemId:item.id
                                             success:^(id response)
     {
         //
         // remove bids from local
         //
         UserData *user = [UserData currentUser];
         
         for (int i = 0; i < user.bidItems.count; i++) {
             ItemData *iData = [user.bidItems objectAtIndex:i];
             if (iData.id == item.id) {
                 [user.bidItems removeObjectAtIndex:i];
             }
         }

         // back to the previous page
         [self.navigationController popViewControllerAnimated:YES];
     }
                                                fail:^(NSError *error, id response)
     {
         [PHUiHelper showAlertView:self title:@"Delete Failed" message:[ApiManager getErrorDescription:error response:response]];
         
         [self.mButDelete setEnabled:YES];
     }];
    
    [self.mButDelete setEnabled:NO];
}

#pragma mark - PCItemViewDelegate

/**
 show bid prices of each user when clicked
 @param index <#index description#>
 */
- (void)onImageItem:(NSInteger)index {
    // get bid data for selected user
    for (BidData *bid in ((ItemData *)self.mItemData).bids) {
        if (index == bid.userId) {
            [mViewBidCore setValueText:[NSString stringWithFormat:@"$%ld", (long)bid.price]];
        }
    }
}

#pragma mark - PCAlertDialogDelegate

- (void)onButAlertPrimary {
    // give up bid
    ItemData *item = (ItemData *)self.mItemData;
    
    // call give up api
    [[ApiManager sharedInstance] giveupBidWithItemId:item.id
                                             success:^(id response)
     {
         // show delete button only
         [self showDeleteButton];
         [self hideTimeOut];
         
         UserData *uData = [UserData currentUser];
         uData.countGivenUp++;
     }
                                                fail:^(NSError *error, id response)
     {
         [PHUiHelper showAlertView:self title:@"Giveup Failed" message:[ApiManager getErrorDescription:error response:response]];
         
         [self.mButGiveup setEnabled:YES];
     }];
    
    [self.mButGiveup setEnabled:NO];
}

@end
