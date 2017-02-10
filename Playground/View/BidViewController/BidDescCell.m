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
#import "ItemData.h"

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
    [self.mLblTitle setFont:[PHTextHelper myriadProSemibold:[PHTextHelper fontSizeNormal]]];
    [self.mLblContent setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    [self.mLblCondition setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    [self.mLblShare setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    //
    // add timeout view
    //
    mViewTimeoutCore = [PCNoticeTimeout getView];
    
    // Set the width of the cell to match the width of the container view
    mViewTimeoutCore.frame = self.mViewTime.bounds;
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
    [mViewRateCore setUserInteractionEnabled:NO];
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

- (void)fillContent:(id)data {
    ItemData *item = (ItemData *)data;
    
    // description
    [self.mLblContent setText:item.desc];
    
    // condition
    [mViewRateCore setRate:item.condition];
    
    // time remaining
    [mViewTimeoutCore setValueText:[item remainTimeLong]];
    
    // price
    [mViewAuctionCore setValueText:[NSString stringWithFormat:@"$%ld", (long)item.price]];
    
    // bid price
    [mViewBidCore setValueText:[NSString stringWithFormat:@"$%ld", (long)[item getMaxBidPrice]]];
}

@end
