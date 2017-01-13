//
//  PCItemView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCItemView.h"

@interface PCItemView()

@property (weak, nonatomic) IBOutlet UIImageView *mImgViewBg;
@property (weak, nonatomic) IBOutlet UIImageView *mImgviewPhoto;
@property (weak, nonatomic) IBOutlet UIButton *mButTime;

@end

@implementation PCItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init borders
    [self.mImgviewPhoto.layer setBorderWidth:2];
    [self.mImgviewPhoto.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self.mButTime.layer setBorderWidth:2];
    [self.mButTime.layer setBorderColor:[UIColor whiteColor].CGColor];
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
    [self.mImgViewBg.layer setMasksToBounds:YES];
    [self.mImgViewBg.layer setCornerRadius:self.mImgViewBg.frame.size.width/2.0];
    
    // photo view
    [self.mImgviewPhoto.layer setMasksToBounds:YES];
    [self.mImgviewPhoto.layer setCornerRadius:self.mImgviewPhoto.frame.size.width/2.0];
    
    // time button
    [self.mButTime.layer setMasksToBounds:YES];
    [self.mButTime.layer setCornerRadius:self.mButTime.frame.size.height/2.0];
}


@end
