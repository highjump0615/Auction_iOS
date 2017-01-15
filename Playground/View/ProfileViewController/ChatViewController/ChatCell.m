//
//  ChatCell.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ChatCell.h"
#import "PHTextHelper.h"
#import "PHUiHelper.h"

@interface ChatCell() {
    double mdHeightTime;
    double mdHeightUsername;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTime;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;
@property (weak, nonatomic) IBOutlet UIView *mViewBubble;
@property (weak, nonatomic) IBOutlet UILabel *mLblBubble;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstTimeHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstHeightUsername;

@end

@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // font
    [self.mLblTime setFont:[PHTextHelper myriadProRegular:10]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:12]];
    [self.mLblBubble setFont:[PHTextHelper myriadProRegular:12]];
    
    // bubble view
    [PHUiHelper setPurpleBorder:self.mViewBubble cornerRadius:15.0];
    
    // init param
    mdHeightTime = 20;
    mdHeightUsername = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 show/hide time label
 @param show <#show description#>
 */
- (void)showTime:(BOOL)show {
    if (show) {
        [self.mLblTime setHighlighted:NO];
        [self.mCstTimeHeight setConstant:mdHeightTime];
    }
    else {
        [self.mLblTime setHighlighted:YES];
        [self.mCstTimeHeight setConstant:0];
    }
}

/**
 show/hide username label
 @param show <#show description#>
 */
- (void)showUsername:(BOOL)show {
    if (show) {
        [self.mLblUsername setHighlighted:NO];
        [self.mCstHeightUsername setConstant:mdHeightUsername];
    }
    else {
        [self.mLblUsername setHighlighted:YES];
        [self.mCstHeightUsername setConstant:0];
    }
}


@end
