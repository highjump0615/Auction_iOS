//
//  BidNoCommentCell.m
//  Playground
//
//  Created by Top1 on 1/30/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidNoCommentCell.h"
#import "PHTextHelper.h"

@interface BidNoCommentCell()

@property (weak, nonatomic) IBOutlet UILabel *mLblNotice;

@end

@implementation BidNoCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // font
    [self.mLblNotice setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
