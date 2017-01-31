//
//  CategoryExploreCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryExploreCell.h"
#import "PCItemView.h"
#import "PHTextHelper.h"

@interface CategoryExploreCell()

@property (weak, nonatomic) IBOutlet UILabel *mLblNotice;

@end

@implementation CategoryExploreCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // font
    [self.mLblNotice setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setNoticeText:(NSString *)value {
    [self.mLblNotice setText:value];
}

- (void)fillContent:(NSInteger)count {
    if (count > 0) {
        [self.mLblNotice setHidden:YES];
    }
    else {
        [self.mLblNotice setHidden:NO];
    }
    
    // refresh collection view
    [self.mCollectionView reloadData];
}

@end
