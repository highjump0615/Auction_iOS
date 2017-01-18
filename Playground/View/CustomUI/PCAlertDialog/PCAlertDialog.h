//
//  PCAlertDialog.h
//  Playground
//
//  Created by Top1 on 1/17/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@interface PCAlertDialog : PCBaseView

+ (id)getView;
- (void)showView:(BOOL)bShow animated:(BOOL)animated;

- (void)setTitle:(NSString *)value;
- (void)setMessage:(NSString *)value;
- (void)setPrimaryButName:(NSString *)value;

@end
