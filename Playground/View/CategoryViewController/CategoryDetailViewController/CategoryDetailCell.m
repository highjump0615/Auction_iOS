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
#import "ItemData.h"

@interface CategoryDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *mLblPrice;

@end

@implementation CategoryDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init price cell
    [self.mLblPrice setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeMedium]]];
    [self.mLblPrice.layer setBorderWidth:1];
    [self.mLblPrice.layer setBorderColor:[PHColorHelper colorTextBlack].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.mLblPrice.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblPrice.frame);
    
    // price label
    [PHUiHelper makeRounded:self.mLblPrice];
}

- (void)fillContent:(id)data {
    [super fillContent:data];
    
    // set price
    ItemData *item = (ItemData *)data;
    [self.mLblPrice setText:[NSString stringWithFormat:@"$%ld", (long)item.price]];
}


@end
