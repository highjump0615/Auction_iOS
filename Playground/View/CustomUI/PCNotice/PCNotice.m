//
//  PCNotice.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCNotice.h"
#import "PHColorHelper.h"

@interface PCNotice()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstMarginMiddle;

@end

@implementation PCNotice

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    mdRadius = 5;
    
    //
    // corner round
    //
    [self.mViewTimeBg.layer setMasksToBounds:YES];
    [self.mViewTimeBg.layer setCornerRadius:mdRadius];
}

/**
 redefine for regulating margin
 @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.mCstMarginTop setConstant:frame.size.height * 0.16f];
    [self.mCstMarginMiddle setConstant:frame.size.height * 0.1f];
}


/**
 add shadow to the view
 @param offset <#offset description#>
 @param opacity <#opacity description#>
 @param radius <#radius description#>
 */
- (void)setShadow:(CGFloat)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = [PHColorHelper colorShadow].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, offset);
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = shadowPath.CGPath;
}

/**
 set title text
 @param value string to set
 */
- (void)setTitle:(NSString *)value {
    [self.mLblTitle setText:value];
}

/**
 set title text
 @param value string to set
 */
- (void)setValueText:(NSString *)value {
    [self.mLblValue setText:value];
}


/**
 set background image
 @param image <#image description#>
 */
- (void)setBackgroundImage:(UIImage *)image {
    [self.mViewTimeBg setImage:image];
}

@end
