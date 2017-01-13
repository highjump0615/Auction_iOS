//
//  PCBorderView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBorderView.h"
#import "PHColorHelper.h"

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
    
    CALayer *borderTop = [CALayer layer];
    borderTop.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [PHColorHelper colorTextGray].CGColor;
    
    borderTop.frame = CGRectMake(0, 0, self.frame.size.width, dBorderWidth);
    borderBottom.frame = CGRectMake(0, self.frame.size.height - dBorderWidth, self.frame.size.width, dBorderWidth);
    
    [self.layer addSublayer:borderTop];
    [self.layer addSublayer:borderBottom];
}

@end
