//
//  InboxCell.h
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ItemBaseCell.h"

@interface InboxCell : ItemBaseCell

@property (weak, nonatomic) IBOutlet UIButton *mButRate;

- (void)fillContent:(id)data;

@end
