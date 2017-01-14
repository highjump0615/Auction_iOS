//
//  CategoryDetailCell.m
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryDetailCell.h"
#import "PCItemView.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"

@interface CategoryDetailCell() {
    PCItemView *mItemView;
}

@property (weak, nonatomic) IBOutlet PCItemView *mViewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;
@property (weak, nonatomic) IBOutlet UILabel *mLblPrice;

@end

@implementation CategoryDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // add item view
    mItemView = [PCItemView getView];
    mItemView.frame = self.mViewPhoto.bounds;
    
    [self.mViewPhoto addSubview:mItemView];
    
    // init labels
    [self.mLblPrice setFont:[PHTextHelper myriadProRegular:14]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:10]];
    
    [self.mLblPrice setFont:[PHTextHelper myriadProRegular:12]];
    [self.mLblPrice.layer setBorderWidth:1];
    [self.mLblPrice.layer setBorderColor:[PHColorHelper colorTextBlack].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // price label
    [PHUiHelper makeRounded:self.mLblPrice];
}

@end
