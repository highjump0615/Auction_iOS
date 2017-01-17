//
//  BidPhotoCollectionCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidPhotoCollectionCell.h"
#import "PHColorHelper.h"

@implementation BidPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // adding border
    [self.contentView.layer setBorderWidth:0.5];
    [self.contentView.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
}


@end
