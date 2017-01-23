//
//  CategoryCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryCell.h"
#import "PHTextHelper.h"
#import "CategoryData.h"

@interface CategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *mImgviewPhoto;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:24]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillContent:(CategoryData *)category {
    // set image
    [self.mImgviewPhoto setImage:[UIImage imageNamed:[category getImageName]]];
    
    // set name
    [self.mLblTitle setText:category.name];
}

@end
