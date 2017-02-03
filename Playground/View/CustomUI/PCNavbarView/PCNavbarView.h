//
//  PSNavBarView.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@interface PCNavbarView : PCBaseView

@property (weak, nonatomic) IBOutlet UIButton *mButBack;
@property (weak, nonatomic) IBOutlet UITextField *mTxtSearch;

+ (id)getView;
- (void)showSearch:(BOOL)showSearch showBack:(BOOL)showBack;
- (void)setTitle:(NSString *)value bold:(BOOL)bold;
- (void)showTitle:(BOOL)show;
- (void)showCongrat:(BOOL)show;

@end
