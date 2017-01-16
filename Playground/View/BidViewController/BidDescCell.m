//
//  BidDescCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidDescCell.h"
#import "PHTextHelper.h"
#import "PCRateView.h"
#import "PHColorHelper.h"

@interface BidDescCell() {
    PCRateView *mViewRateCore;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblContent;

@property (weak, nonatomic) IBOutlet UILabel *mLblCondition;
@property (weak, nonatomic) IBOutlet UIView *mViewRate;

@property (weak, nonatomic) IBOutlet UIView *mViewTime;
@property (weak, nonatomic) IBOutlet UILabel *mLblTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblTime;

@property (weak, nonatomic) IBOutlet UIView *mViewAuction;
@property (weak, nonatomic) IBOutlet UILabel *mLblAuctionTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblAuction;

@property (weak, nonatomic) IBOutlet UIView *mViewBid;
@property (weak, nonatomic) IBOutlet UILabel *mLblBidTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblBid;

@property (weak, nonatomic) IBOutlet UILabel *mLblShare;

@end

@implementation BidDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //
    // font
    //
//    [self.mLblTitle setFont:[PHTextHelper myriadProSemibold:14]];
//    [self.mLblContent setFont:[PHTextHelper myriadProRegular:14]];
//    
//    [self.mLblCondition setFont:[PHTextHelper myriadProRegular:14]];
//    
//    [self.mLblTimeTitle setFont:[PHTextHelper myriadProBold:21]];
//    [self.mLblTime setFont:[PHTextHelper myriadProBold:35]];
//    
//    [self.mLblAuctionTitle setFont:[PHTextHelper myriadProBold:18]];
//    [self.mLblAuction setFont:[PHTextHelper myriadProBold:22]];
//    
//    [self.mLblBidTitle setFont:[PHTextHelper myriadProBold:18]];
//    [self.mLblBid setFont:[PHTextHelper myriadProBold:22]];
//    
//    [self.mLblShare setFont:[PHTextHelper myriadProRegular:14]];
//    
//    //
//    // add rate view
//    //
//    mViewRateCore = [PCRateView getView];
//    mViewRateCore.frame = self.mViewRate.bounds;
//    [self.mViewRate addSubview:mViewRateCore];
//    
//    //
//    // corner round
//    //
//    double dRadius = 5;
//    
//    [self.mViewTime.layer setMasksToBounds:YES];
//    [self.mViewTime.layer setCornerRadius:dRadius];
//    
//    [self.mViewAuction.layer setMasksToBounds:YES];
//    [self.mViewAuction.layer setCornerRadius:dRadius];
//    
//    [self.mViewBid.layer setMasksToBounds:YES];
//    [self.mViewBid.layer setCornerRadius:dRadius];
//    
//    //
//    // shadow
//    //
//    self.mViewTime.layer.shadowColor = [PHColorHelper colorTextGray].CGColor;
//    self.mViewTime.layer.shadowOffset = CGSizeMake(10, 10);
//    
//    self.mViewAuction.layer.shadowColor = [PHColorHelper colorTextGray].CGColor;
//    self.mViewAuction.layer.shadowOffset = CGSizeMake(10, 10);
//    
//    self.mViewBid.layer.shadowColor = [PHColorHelper colorTextGray].CGColor;
//    self.mViewBid.layer.shadowOffset = CGSizeMake(10, 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
