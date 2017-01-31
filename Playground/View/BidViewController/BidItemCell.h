//
//  BidItemCell.h
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidItemCell : UITableViewCell

@property (weak, nonatomic) id delegate;

- (void)fillContent:(id)data;

@end
