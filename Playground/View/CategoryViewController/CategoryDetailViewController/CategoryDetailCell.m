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
