//
//  ProfileStatisticsCell.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ProfileStatisticsCell.h"
#import "PHTextHelper.h"

@interface ProfileStatisticsCell()

@property (weak, nonatomic) IBOutlet UILabel *mLblAuction;
@property (weak, nonatomic) IBOutlet UILabel *mLblAuctionCount;
@property (weak, nonatomic) IBOutlet UILabel *mLblBid;
@property (weak, nonatomic) IBOutlet UILabel *mLblBidCount;
@property (weak, nonatomic) IBOutlet UILabel *mLblGiveup;
@property (weak, nonatomic) IBOutlet UILabel *mLblGiveupCount;
@property (weak, nonatomic) IBOutlet UILabel *mLblRating;
@property (weak, nonatomic) IBOutlet UILabel *mLblRatingValue;

@end

@implementation ProfileStatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init font
    double dFontSize = 14;
    
    [self.mLblAuction setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblAuctionCount setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblBid setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblBidCount setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblGiveup setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblGiveupCount setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblRating setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblRatingValue setFont:[PHTextHelper myriadProRegular:dFontSize]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end