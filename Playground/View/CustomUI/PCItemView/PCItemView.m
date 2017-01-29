//
//  PCItemView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCItemView.h"
#import "PHUiHelper.h"
#import "PHTextHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ItemData.h"
#import "ApiConfig.h"

@interface PCItemView() {
    ItemData *mItem;
}

@property (weak, nonatomic) IBOutlet UIImageView *mImgViewBg;
@property (weak, nonatomic) IBOutlet UIImageView *mImgviewPhoto;
@property (weak, nonatomic) IBOutlet UIButton *mButTime;

@end

@implementation PCItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init borders
    [self.mImgviewPhoto.layer setBorderWidth:3];
    [self.mImgviewPhoto.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self.mButTime.layer setBorderWidth:2];
    [self.mButTime.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    // font
    [self.mButTime.titleLabel setFont:[PHTextHelper myriadProLight:12]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView {
    return [super getView:@"PCItemView"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //
    // init item view
    //
    
    // border view
    [PHUiHelper makeRounded:self.mImgViewBg];
    
    // photo view
    [PHUiHelper makeRounded:self.mImgviewPhoto];
    
    // time button
    [PHUiHelper makeRounded:self.mButTime];
}


/**
 show/hide time limit on the bottom
 @param show <#show description#>
 */
- (void)showTimeLimit:(BOOL)show {
    [self.mButTime setHidden:!show];
}

- (void)setItemData:(id)item {
    mItem = (ItemData *)item;
    
    [self.mImgviewPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", PH_API_BASE_ITEM_FILE_URL, mItem.coverImage]]];
}

@end
