//
//  PCBorderView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBorderView.h"
#import "PHColorHelper.h"

@interface PCBorderView() {
    CALayer *mborderTop;
    CALayer *mborderBottom;
    
    double mdBorderWidth;
}

@end

@implementation PCBorderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // init param
    mdBorderWidth = 0.5;
}

/**
 remove bottom border
 */
- (void)removeBottom {
    [mborderBottom removeFromSuperlayer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //
    // add top border
    //
    mborderTop = [CALayer layer];
    mborderTop.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    mborderTop.frame = CGRectMake(0, 0, self.frame.size.width, mdBorderWidth);
    [self.layer addSublayer:mborderTop];
    
    // remove bottomborder if exist
    if (mborderBottom) {
        [mborderBottom removeFromSuperlayer];
    }

    //
    // add bottom border
    //
    mborderBottom = [CALayer layer];
    mborderBottom.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    mborderBottom.frame = CGRectMake(0, self.frame.size.height - mdBorderWidth, self.frame.size.width, mdBorderWidth);
    [self.layer addSublayer:mborderBottom];
}

@end
