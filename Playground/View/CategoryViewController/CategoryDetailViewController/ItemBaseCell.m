//
//  ItemBaseCell.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemBaseCell.h"
#import "PCItemView.h"
#import "PHTextHelper.h"

@interface ItemBaseCell() {
    PCItemView *mItemView;
}

@property (weak, nonatomic) IBOutlet PCItemView *mViewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;

@end

@implementation ItemBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // add item view
    mItemView = [PCItemView getView];
    mItemView.frame = self.mViewPhoto.bounds;
    
    [self.mViewPhoto addSubview:mItemView];
    
    // init labels
    [self.mLblTitle setFont:[PHTextHelper myriadProRegular:14]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:10]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
