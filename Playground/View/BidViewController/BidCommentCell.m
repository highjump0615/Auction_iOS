//
//  BidCommentCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidCommentCell.h"

@interface BidCommentCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstBubbleMargin;

@end

@implementation BidCommentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)fillContent {
    [self.mCstBubbleMargin setConstant:39];
}

@end
