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
    
    //
    // add top & bottom border
    //
    double dBorderWidth = 0.5;
    
    mborderTop = [CALayer layer];
    mborderTop.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    mborderTop.frame = CGRectMake(0, 0, self.frame.size.width, dBorderWidth);
    [self.layer addSublayer:mborderTop];
    
    mborderBottom = [CALayer layer];
    mborderBottom.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    mborderBottom.frame = CGRectMake(0, self.frame.size.height - dBorderWidth, self.frame.size.width, dBorderWidth);
    [self.layer addSublayer:mborderBottom];
}

/**
 remove bottom border
 */
- (void)removeBottom {
    [mborderBottom removeFromSuperlayer];
}

@end
