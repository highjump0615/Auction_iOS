//
//  BidPhotoCollectionCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidPhotoCollectionCell.h"
#import "PHColorHelper.h"
#import "UserData.h"
#import "ApiConfig.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BidPhotoCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *mImgView;

@end

@implementation BidPhotoCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // adding border
    [self.contentView.layer setBorderWidth:0.5];
    [self.contentView.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
}

- (void)fillContent:(NSString *)path {
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_ITEM_FILE_URL, path];
    [self.mImgView sd_setImageWithURL:[NSURL URLWithString:strUrl]];
}

@end
