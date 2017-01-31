//
//  ProfileUserCell.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ProfileUserCell.h"
#import "PHUiHelper.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserData.h"

@interface ProfileUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *mImgviewUser;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;

@end

@implementation ProfileUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // make border
    [self.mImgviewUser.layer setBorderWidth:0.5];
    [self.mImgviewUser.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
    
    // set font
    [self.mLblUsername setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeSemiLarge]]];
    
    // set content
    UserData *currentUser = [UserData currentUser];
    [self.mImgviewUser sd_setImageWithURL:[NSURL URLWithString:[currentUser photoUrl]]];
    [self.mLblUsername setText:currentUser.name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // init UI
    [PHUiHelper makeRounded:self.mImgviewUser];
}

@end
