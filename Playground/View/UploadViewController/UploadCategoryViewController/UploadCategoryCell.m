//
//  UploadCategoryCell.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UploadCategoryCell.h"
#import "PHTextHelper.h"

@interface UploadCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *mLblName;

@end

@implementation UploadCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mLblName setFont:[PHTextHelper myriadProRegular:14]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
