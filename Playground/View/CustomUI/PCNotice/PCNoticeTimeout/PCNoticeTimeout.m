//
//  PCNoticeTimeout.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCNoticeTimeout.h"
#import "PHTextHelper.h"

@interface PCNoticeTimeout()

@end


@implementation PCNoticeTimeout

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //
    // font
    //
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:21]];
    [self.mLblValue setFont:[PHTextHelper myriadProBold:35]];
}

+ (id)getView {
    return [super getView:@"PCNoticeTimeout"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // shadow
    [self setShadow:10 opacity:0.5f radius:10];
}


@end
