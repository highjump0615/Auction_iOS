//
//  CategoryExploreCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryExploreCell.h"
#import "PCItemView.h"

@interface CategoryExploreCell() {
    PCItemView *mItemView;
}

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@end

@implementation CategoryExploreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // add item view
    mItemView = [PCItemView getView];
    mItemView.frame = self.bounds;
    
    [self.maskView addSubview:mItemView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
