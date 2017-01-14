//
//  PSNavBarView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCNavbarView.h"
#import "PHTextHelper.h"

@interface PCNavbarView()

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
        [self.mCstSapcing setConstant:13];
        [self.mCstBackWidth setConstant:0];
        [self.mButBack setHidden:YES];
    }
}

@end
