//
//  PCNoticePrice.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCNoticePrice.h"
#import "PHTextHelper.h"

@implementation PCNoticePrice

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
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:[PHTextHelper fontNoticeSmall]]];
    [self.mLblValue setFont:[PHTextHelper myriadProBold:[PHTextHelper fontNoticeMedium]]];
}

+ (id)getView {
    return [super getView:@"PCNoticePrice"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // shadow
    [self setShadow:5 opacity:0.5f radius:5];
}


@end
