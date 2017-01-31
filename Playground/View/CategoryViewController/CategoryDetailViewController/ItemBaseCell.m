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


@end
