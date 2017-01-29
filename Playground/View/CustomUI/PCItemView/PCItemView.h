//
//  PCItemView.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@interface PCItemView : PCBaseView

+ (id)getView;
- (void)showTimeLimit:(BOOL)show;

- (void)setItemData:(id)item;

@end
