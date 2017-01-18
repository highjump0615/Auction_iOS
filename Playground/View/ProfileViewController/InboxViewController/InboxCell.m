//
//  InboxCell.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "InboxCell.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"

@interface InboxCell()

@end

@implementation InboxCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // init rate button
    [self.mButRate.titleLabel setFont:[PHTextHelper myriadProRegular:12]];
    [self.mButRate.layer setBorderWidth:1];
    [self.mButRate.layer setBorderColor:[PHColorHelper colorTextBlack].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // price label
    [PHUiHelper makeRounded:self.mButRate];
}


@end
