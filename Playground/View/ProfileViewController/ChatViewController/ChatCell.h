//
//  ChatCell.h
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mLblTime;
@property (weak, nonatomic) IBOutlet UILabel *mLblUsername;
@property (weak, nonatomic) IBOutlet UILabel *mLblBubble;

- (void)showTime:(BOOL)show;
- (void)showUsername:(BOOL)show;

@end
