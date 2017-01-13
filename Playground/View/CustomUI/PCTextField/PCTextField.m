//
//  PLTextField.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCTextField.h"

@interface PCTextField() {
    int mnLeftMargin;
}
@end

@implementation PCTextField

- (void) awakeFromNib {
    [super awakeFromNib];
    
    mnLeftMargin = 10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, mnLeftMargin, 0);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, mnLeftMargin, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, mnLeftMargin, 0);
}


@end
