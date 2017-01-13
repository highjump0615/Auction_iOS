//
//  CategoryCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryCell.h"
#import "PHTextHelper.h"

@interface CategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *mImgviewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:20]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
