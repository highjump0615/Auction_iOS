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
#import "ItemData.h"

@interface ItemBaseCell() {
    PCItemView *mItemView;
}

@property (weak, nonatomic) IBOutlet UIView *mViewPhoto;
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
    [self.mLblTitle setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeSmall]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillContent:(id)data {
    ItemData *item = (ItemData *)data;
    
    [mItemView setItemData:item];
    [self.mLblTitle setText:item.title];
    [self.mLblUsername setText:item.username];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.mLblTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblTitle.frame);
    self.mLblUsername.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblUsername.frame);
}


@end
