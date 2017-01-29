//
//  ItemCollectionCell.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemCollectionCell.h"
#import "PCItemView.h"
#import "ItemData.h"

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

/**
 show/hide time limit on the bottom
 @param show <#show description#>
 */
- (void)showTimeLimit:(BOOL)show {
    [mItemView showTimeLimit:show];
}

- (void)fillContent:(id)data {
    [mItemView setItemData:data];
}

@end
