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
#import "UserData.h"

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
    
    // add click target to image view
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImage:)];
    [singleTap setNumberOfTapsRequired:1];
    singleTap.cancelsTouchesInView = NO;
    [self.mImgviewPhoto addGestureRecognizer:singleTap];
    
    [self.mImgviewPhoto setUserInteractionEnabled:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)onImage:(UITapGestureRecognizer *) sender {
    PCItemView *viewItem = (PCItemView *)sender.view;
    
    if (!self.delegate) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(onImageItem:)]) {
        [self.delegate onImageItem:viewItem.tag];
    }
}

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
    
    [self.mImgviewPhoto sd_setImageWithURL:[NSURL URLWithString:[mItem getCoverImageUrl]]];
    [self.mButTime setTitle:[mItem remainTime] forState:UIControlStateNormal];
    
    //
    // set border color
    //
    UserData *user = [UserData currentUser];
    
    // 1. yellow if its current user's
    if ([mItem.username isEqualToString:user.username]) {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"yellow_bg"]];
    }
    // 2. purple if bid is over
    else if ([mItem getRemainMinutes] <= 0) {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"purple_bg"]];
    }
    // 3. blue if current user is in highest bid
    else if ([mItem getMaxBidUser] == user.id) {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"blue_bg"]];
    }
    // 4. red in other cases
    else {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"red_bg"]];
    }
    
    // set tag for delegate
    [self.mImgviewPhoto setTag:mItem.id];
}

- (void)setUserData:(id)user item:(id)item {
    UserData *uData = (UserData *)user;
    ItemData *iData = (ItemData *)item;
    
    [self.mImgviewPhoto sd_setImageWithURL:[NSURL URLWithString:[uData photoUrl]]];
    
    //
    // set border color
    //
    
    // 1. blue if current user is in highest bid
    if ([iData getMaxBidUser] == uData.id) {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"blue_bg"]];
    }
    // 2. red in other cases
    else {
        [self.mImgViewBg setImage:[UIImage imageNamed:@"red_bg"]];
    }
    
    // set tag for delegate
    [self.mImgviewPhoto setTag:mItem.id];
}


@end
