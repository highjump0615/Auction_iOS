//
//  BidInputViewController.m
//  Playground
//
//  Created by Top1 on 1/17/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidInputViewController.h"
#import "PCItemView.h"
#import "PHUiHelper.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PCNoticePrice.h"
#import "ItemData.h"
#import "ApiManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserData.h"

@interface BidInputViewController () {
    PCItemView *mViewItemCore;
    PCNoticePrice *mViewAuctionCore;
    PCNoticePrice *mViewBidCore;
    
    ItemData *mItem;
}

@property (weak, nonatomic) IBOutlet UIView *mViewItem;
@property (weak, nonatomic) IBOutlet UILabel *mLblItemname;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;

@property (weak, nonatomic) IBOutlet UIView *mViewAuction;
@property (weak, nonatomic) IBOutlet UIView *mViewBid;
@property (weak, nonatomic) IBOutlet UILabel *mLblLimit;

@property (weak, nonatomic) IBOutlet UIButton *mButBid;
@property (weak, nonatomic) IBOutlet UITextField *mTextBid;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstItemMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstBidMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstItemWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstItemHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstNoticeHeight;

@end

@implementation BidInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // font
    [self.mButBid.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:10]];
    [self.mLblLimit setFont:[PHTextHelper myriadProRegular:10]];
    
    // bid button
    [PHUiHelper makeRounded:self.mButBid];
    
    // keyboard event
    [self enableKeyboardNotification];
    
    //
    // input text field
    //
    [PHTextHelper initTextRegular:self.mTextBid];
    
    [self.mTextBid.layer setBorderColor:[PHColorHelper colorTextBlack].CGColor];
    [self.mTextBid.layer setBorderWidth:1.0];
    [PHUiHelper makeRounded:self.mTextBid];
    
    // add item view
    mViewItemCore = [PCItemView getView];
    mViewItemCore.frame = self.mViewItem.bounds;
    [self.mViewItem addSubview:mViewItemCore];
    
    //
    // add auction view
    //
    mViewAuctionCore = [PCNoticePrice getView];
    mViewAuctionCore.frame = self.mViewAuction.bounds;
    [mViewAuctionCore setTitle:@"Auctioned At"];
    [self.mViewAuction addSubview:mViewAuctionCore];
    
    //
    // add bid view
    //
    mViewBidCore = [PCNoticePrice getView];
    mViewBidCore.frame = self.mViewBid.bounds;
    [mViewBidCore setTitle:@"Current Bid"];
    [mViewBidCore setBackgroundImage:[PHUiHelper redBackground]];
    
    [self.mViewBid addSubview:mViewBidCore];
    
    // margin
    if ([PHUiHelper deviceType] == PHDevice_iPhone5) {
        // spacing
        [self.mCstItemMargin setConstant:10];
        [self.mCstBidMargin setConstant:10];
        
        // item photo size
        [self.mCstItemWidth setConstant:90];
        [self.mCstItemHeight setConstant:90];
        
        // notice height
        [self.mCstNoticeHeight setConstant:78];
    }
    
    //
    // fill contents
    //
    
    // image
    [mViewItemCore setItemData:mItem];
    
    // title
    [self.mLblItemname setText:mItem.title];
    [self.mLblUsername setText:mItem.username];
    
    // price
    [mViewAuctionCore setValueText:[NSString stringWithFormat:@"$%ld", mItem.price]];
    
    // bid price
    [mViewBidCore setValueText:[NSString stringWithFormat:@"$%ld", mItem.maxBid]];
    
    // label limit
    [self.mLblLimit setText:[NSString stringWithFormat:@"Your bid must be higher than $%ld", mItem.maxBid]];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.mTextBid becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)onButBid:(id)sender {
    // check validity
    if (self.mTextBid.text.length == 0) {
        [PHUiHelper showAlertView:self message:@"Input your price"];
    }
    
    NSInteger nPrice = [self.mTextBid.text integerValue];
    if (nPrice < mItem.maxBid) {
        [PHUiHelper showAlertView:self message:@"Your price is not enough"];
        return;
    }
    
    //
    // call bid api
    //
    [[ApiManager sharedInstance] placeBidWithPrice:nPrice
                                              item:mItem.id
                                           success:^(id response)
     {
         // hide progress view
         [SVProgressHUD dismiss];
         
         // update max bid price
         mItem.maxBid = nPrice;
         
         // add item to user's bid items
         UserData *user = [UserData currentUser];
         [user.bidItems addObject:mItem];

         // back to prev page
         [self.navigationController popViewControllerAnimated:YES];
     }
                                                   fail:^(NSError *error, id response)
     {
         // hide progress view
         [SVProgressHUD dismiss];
         
         NSString *strDesc = [error localizedDescription];
         
         [PHUiHelper showAlertView:self title:@"Bid failed" message:strDesc];
     }];
    
    // show progress view
    [SVProgressHUD show];
}


@end
