//
//  BidCommentCell.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidCommentCell.h"
#import "CommentData.h"
#import "PHDataHelper.h"

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

- (void)fillContent:(id)data {
    CommentData *comment = (CommentData *)data;
    
    // time
    [self.mLblTime setText:[PHDataHelper dateToString:comment.createdAt format:@"yyyy-MM-dd HH:mm:ss"]];
    
    // username
    [self.mLblUsername setText:comment.username];
    
    // comment
    [self.mLblBubble setText:comment.comment];
    
    // indent
    if (comment.parent > 0) {
        [self.mCstBubbleMargin setConstant:39];
    }
    else {
        [self.mCstBubbleMargin setConstant:16];
    }
}

@end
