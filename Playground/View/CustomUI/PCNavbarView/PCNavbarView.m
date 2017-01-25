//
//  PSNavBarView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCNavbarView.h"
#import "PHTextHelper.h"
#import "PHUiHelper.h"

@interface PCNavbarView()

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mImgviewCongrat;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstSapcing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCstBackWidth;

@end

@implementation PCNavbarView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // initialize search textfield
    [self.mTxtSearch.layer setMasksToBounds:YES];
    [self.mTxtSearch.layer setCornerRadius:5];
    
    [PHTextHelper initTextRegular:self.mTxtSearch];
    
    // init title label
    [self.mLblTitle setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormalLarge]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView {
    return [super getView:@"PCNavbarView"];
}


/**
 show/hide search text field
 @param showSearch <#showSearch description#>
 @param showBack show/hide back button
 */
- (void)showSearch:(BOOL)showSearch showBack:(BOOL)showBack {

    [self.mTxtSearch setHidden:!showSearch];
    
    if (showBack) {
        // show back button
        [self.mCstSapcing setConstant:0];
        [self.mCstBackWidth setConstant:44];
        [self.mButBack setHidden:NO];
    }
    else {
        // hide back button
        [self.mCstSapcing setConstant:[PHUiHelper marginLeftNormal]];
        [self.mCstBackWidth setConstant:0];
        [self.mButBack setHidden:YES];
    }
}

/**
 show/hide title label
 @param show <#show description#>
 */
- (void)showTitle:(BOOL)show {
    [self.mLblTitle setHidden:!show];
}

/**
 show/hide congratulations title
 @param show <#show description#>
 */
- (void)showCongrat:(BOOL)show {
    [self.mImgviewCongrat setHidden:!show];
}


@end
