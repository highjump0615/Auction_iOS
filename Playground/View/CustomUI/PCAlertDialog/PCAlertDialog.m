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
    [self.mViewContent.layer setCornerRadius:5];
    
    // title
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:18]];
    
    // message
    [self.mLblMessage setFont:[PHTextHelper myriadProRegular:14]];
    
    // primary button
    [self.mButPrimary.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
    [PHUiHelper makeRounded:self.mButPrimary];
    
    // cancel button
    [self.mButCancel.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
    
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

+ (id)getView {
    return [super getView:@"PCAlertDialog"];
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

@end
