//
//  ItemCollectionCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemCollectionCell.h"
#import "PCItemView.h"

@interface ItemCollectionCell() {
    PCItemView *mItemView;
}

@end

@implementation ItemCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // add item view
    mItemView = [PCItemView getView];
    mItemView.frame = self.bounds;
    
    [self.contentView addSubview:mItemView];
}

@end
