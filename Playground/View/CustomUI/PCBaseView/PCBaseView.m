//
//  BaseView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@implementation PCBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView:(NSString *)nibName {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    PCBaseView *view = [[PCBaseView alloc] init];
    view = (PCBaseView *)[nib objectAtIndex:0];
    
    return view;
}

@end
