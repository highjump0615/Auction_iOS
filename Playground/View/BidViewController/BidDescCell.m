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
#import "PCNoticeTimeout.h"
#import "PCNoticePrice.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"

@interface BidDescCell() {
    PCNoticeTimeout *mViewTimeoutCore;
    PCNoticePrice *mViewAuctionCore;
    PCNoticePrice *mViewBidCore;
    PCRateView *mViewRateCore;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblContent;

@property (weak, nonatomic) IBOutlet UILabel *mLblCondition;
@property (weak, nonatomic) IBOutlet UIView *mViewRate;

@property (weak, nonatomic) IBOutlet UIView *mViewTime;

@property (weak, nonatomic) IBOutlet UIView *mViewAuction;
@property (weak, nonatomic) IBOutlet UIView *mViewBid;

@property (weak, nonatomic) IBOutlet UILabel *mLblShare;

@end

@implementation BidDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //
    // font
    //
    [self.mLblTitle setFont:[PHTextHelper myriadProSemibold:14]];
    [self.mLblContent setFont:[PHTextHelper myriadProRegular:14]];
    
    [self.mLblCondition setFont:[PHTextHelper myriadProRegular:14]];
    
    [self.mLblShare setFont:[PHTextHelper myriadProRegular:14]];
    
    //
    // add timeout view
    //
    mViewTimeoutCore = [PCNoticeTimeout getView];
    
    // Set the width of the cell to match the width of the container view
    mViewTimeoutCore.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.mViewTime.bounds), CGRectGetHeight(mViewTimeoutCore.bounds));
    [self.mViewTime addSubview:mViewTimeoutCore];
    
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
    [mViewBidCore setTitle:@"Current Bid"];
    [mViewBidCore setValueText:@"$220"];
    [mViewBidCore setBackgroundImage:[PHUiHelper redBackground]];
    
    [self.mViewBid addSubview:mViewBidCore];
    
    //
    // add rate view
    //
    mViewRateCore = [PCRateView getView];
    mViewRateCore.frame = self.mViewRate.bounds;
    [self.mViewRate addSubview:mViewRateCore];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.mLblTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblTitle.frame);
    self.mLblContent.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblContent.frame);
}


@end
