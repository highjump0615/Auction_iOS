//
//  PCItemView.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@protocol PCItemViewDelegate<NSObject>

@optional
- (void)onImageItem:(NSInteger)index;

@end

@interface PCItemView : PCBaseView

@property (weak, nonatomic) id <PCItemViewDelegate> delegate;

+ (id)getView;
- (void)showTimeLimit:(BOOL)show;

- (void)setItemData:(id)item;
- (void)setUserData:(id)user item:(id)item;

@end
