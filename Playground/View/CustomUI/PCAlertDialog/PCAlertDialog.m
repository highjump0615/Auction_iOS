//
//  PCAlertDialog.m
//  Playground
//
//  Created by Top1 on 1/17/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCAlertDialog.h"
#import "PHTextHelper.h"
#import "PHUiHelper.h"

@interface PCAlertDialog()

@property (weak, nonatomic) IBOutlet UIView *mViewContent;
@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblMessage;

@property (weak, nonatomic) IBOutlet UIButton *mButPrimary;
@property (weak, nonatomic) IBOutlet UIButton *mButCancel;

@end

@implementation PCAlertDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];

    // content view
    [self.mViewContent.layer setMasksToBounds:YES];
    [self.mViewContent.layer setCornerRadius:8];
    
    // title
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:18]];
    
    // message
    [self.mLblMessage setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // primary button
    [self.mButPrimary.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // cancel button
    [self.mButCancel.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // add tap guesture
    if ([self.gestureRecognizers count] == 0) {
        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc]
                                                       initWithTarget:self action:@selector(didRecognizeSingleTap:)];
        [singleTapRecognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTapRecognizer];
    }
    
    // init alpha
    [self setAlpha:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.mLblMessage.preferredMaxLayoutWidth = CGRectGetWidth(self.mLblMessage.frame);
    
    [PHUiHelper makeRounded:self.mButPrimary];
}

- (void)updateConstraints {
    [super updateConstraints];
}

+ (id)getView {
    // primary button
    return [super getView:@"PCAlertDialog"];
}

/**
 set title of the alert
 @param value <#value description#>
 */
- (void)setTitle:(NSString *)value {
    [self.mLblTitle setText:value];
}

/**
 set message of the alert
 @param value <#value description#>
 */
- (void)setMessage:(NSString *)value {
    [self.mLblMessage setText:value];
}

/**
 set title of the primary button
 @param value <#value description#>
 */
- (void)setPrimaryButName:(NSString *)value {
    [self.mButPrimary setTitle:value forState:UIControlStateNormal];
}

/**
 show/hide alert dialog
 @param bShow <#bShow description#>
 @param animated <#animated description#>
 */
- (void)showView:(BOOL)bShow animated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [self setHidden:NO];
                             [self setAlpha:bShow];
                         }completion:^(BOOL finished) {
                             [self setHidden:!bShow];
                         }];
    }
    else {
        [self setAlpha:bShow];
        [self setHidden:!bShow];
    }
}

- (void)didRecognizeSingleTap:(id)sender
{
    [self showView:NO animated:YES];
}

- (IBAction)onButCancel:(id)sender {
    [self showView:NO animated:YES];
}

- (IBAction)onButPrimary:(id)sender {
    
    // do operation
    if (!self.delegate) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(onButAlertPrimary)]) {
        [self.delegate onButAlertPrimary];
    }

    [self showView:NO animated:YES];
}

@end
