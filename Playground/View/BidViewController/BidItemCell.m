//
//  BidItemCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidItemCell.h"
#import "PCItemView.h"
#import "BidViewController.h"
#import "PHTextHelper.h"
#import "PHUiHelper.h"
#import "ItemData.h"
#import "UserData.h"

@interface BidItemCell() {
    NSMutableArray *maryButTab;
    NSMutableArray *maryImgNormal;
    NSMutableArray *maryImgSelected;
    
    PCItemView *mViewItemCore;
}

@property (weak, nonatomic) IBOutlet UIView *mViewItem;
@property (weak, nonatomic) IBOutlet UILabel *mLblItemname;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;

@property (weak, nonatomic) IBOutlet UIButton *mButBid;

@property (weak, nonatomic) IBOutlet UIButton *mButDesc;
@property (weak, nonatomic) IBOutlet UIButton *mButPhoto;
@property (weak, nonatomic) IBOutlet UIButton *mButComment;

@end

@implementation BidItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // add item view
    mViewItemCore = [PCItemView getView];
    mViewItemCore.frame = self.mViewItem.bounds;
    
    [self.mViewItem addSubview:mViewItemCore];
    
    // font
    [self.mLblItemname setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblUsername setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeSmall]]];
    [self.mButBid.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeMedium]]];
    
    //
    // tab buttons
    //
    maryButTab = [[NSMutableArray alloc] init];
    maryImgNormal = [[NSMutableArray alloc] init];
    maryImgSelected = [[NSMutableArray alloc] init];
    
    // add button objects
    [maryButTab addObject:self.mButDesc];
    [maryImgNormal addObject:@"bid_desc"];
    [maryImgSelected addObject:@"bid_desc_selected"];
    
    [maryButTab addObject:self.mButPhoto];
    [maryImgNormal addObject:@"bid_photo"];
    [maryImgSelected addObject:@"bid_photo_selected"];
    
    [maryButTab addObject:self.mButComment];
    [maryImgNormal addObject:@"bid_comment"];
    [maryImgSelected addObject:@"bid_comment_selected"];
    
    for (UIButton *button in maryButTab) {
        [button addTarget:self action:@selector(onButTab:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 event handler for tab buttons
 @param sender tab button
 */
- (void)onButTab:(id)sender {
    NSInteger nTag = ((UIButton *)sender).tag;
    
    int nTab = (int)nTag;
    
    // update view content
    BidViewController *viewController = (BidViewController *)self.delegate;
    [viewController setSelectedTab:nTab];
    
    // init button icon with normal image
    int i = 0;
    for (i = 0; i < [maryButTab count]; i++) {
        UIButton *button = maryButTab[i];
        [button setImage:[UIImage imageNamed:maryImgNormal[i]] forState:UIControlStateNormal];
    }
    
    // set selected button icon
    UIButton *button = maryButTab[nTab];
    [button setImage:[UIImage imageNamed:maryImgSelected[nTab]] forState:UIControlStateNormal];
}

- (void)fillContent:(id)data {
    ItemData *item = (ItemData *)data;
    
    // photo
    [mViewItemCore setItemData:data];
    
    // label data
    [self.mLblItemname setText:item.title];
    [self.mLblUsername setText:item.username];
    
    // disable bid button if it is his own
    UserData *user = [UserData currentUser];
    if ([item.username isEqualToString:user.username]) {
        [self.mButBid setEnabled:NO];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // bid button    
    [PHUiHelper makeRounded:self.mButBid];
}


@end
