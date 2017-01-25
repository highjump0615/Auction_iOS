//
//  BidCommentCell.h
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ChatCell.h"

@interface BidCommentCell : ChatCell

@property (weak, nonatomic) IBOutlet UIButton *mButReply;

- (void)fillContent;

@end
