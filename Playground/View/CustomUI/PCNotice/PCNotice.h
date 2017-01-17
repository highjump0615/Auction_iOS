//
//  PCNotice.h
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

@interface PCNotice : PCBaseView {
    double mdRadius;
}

@property (weak, nonatomic) IBOutlet UIImageView *mViewTimeBg;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblValue;

- (void)setShadow:(CGFloat)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

- (void)setBackgroundImage:(UIImage *)image;
- (void)setTitle:(NSString *)value;
- (void)setValueText:(NSString *)value;

@end
