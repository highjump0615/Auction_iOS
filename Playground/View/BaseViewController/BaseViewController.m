//
//  BaseViewController.m
//  Playground
//
//  Created by Administrator on 1/12/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"
#import "PHTextHelper.h"
#import "PCNavbarView.h"

@interface BaseViewController () {
    PCNavbarView *mNavbar;
}

@property (weak, nonatomic) IBOutlet UIView *mViewNavbar;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add navigation bar view
    mNavbar = [PCNavbarView getView];
    mNavbar.frame = self.mViewNavbar.bounds;
    
    // back button
    [mNavbar.mButBack addTarget:self action:@selector(onButBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mViewNavbar addSubview:mNavbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 Initialize signup & login buttons
 */
- (void)initLoginButton:(UIButton *)button {
    // make them rounded
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:7];
    [button.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
}

/**
 Initialize round buttons
 */
- (void)initRoundButton:(UIButton *)button {
    // make them rounded
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:button.frame.size.height / 2.0];
    [button.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
}

/**
 Hides keyboard
 @param sender -
 */
- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self.view endEditing:YES];
}

/**
 back to prev page
 @param sender sender description
 */
- (void)onButBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 show/hide search text field
 @param showSearch <#showSearch description#>
 @param showBack show/hide back button
 */
- (void)showSearch:(BOOL)showSearch showBack:(BOOL)showBack {
    [mNavbar showSearch:showSearch showBack:showBack];
}

/**
 show/hide title label
 @param show <#show description#>
 */
- (void)showTitle:(BOOL)show {
    [mNavbar showTitle:YES];
}


- (void)setSearchDelegate:(UIViewController<UITextFieldDelegate> *)controller {
    [mNavbar.mTxtSearch setDelegate:controller];
}

/**
 initialze table view for data
 @param tableview <#tableview description#>
 */
- (void)initTableView:(UITableView *)tableview haveBottombar:(BOOL)haveBottombar {
    // set margin for tableview
    UIEdgeInsets edgeTable = tableview.contentInset;
    edgeTable.top = 44;
    
    // if has bottom tab bar
    if (haveBottombar) {
        edgeTable.bottom = 50;
    }
    
    [tableview setContentInset:edgeTable];
    
    [tableview setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.bounds.size.width, 0.01f)]];
    [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.bounds.size.width, 0.01f)]];
}


/**
 get search string on nav bar
 @return <#return value description#>
 */
- (NSString *)getSearchString {
    return mNavbar.mTxtSearch.text;
}


/**
 add keyboard show & hide notification
 */
- (void)enableKeyboardNotification {
    // keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

/**
 shrink the screen
 @param yPos size
 */
- (void)animationView:(CGFloat)yPos {
    
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait)
    {
        CGSize sz = [[UIScreen mainScreen] bounds].size;
        if(yPos == sz.height - self.view.frame.size.height)
            return;
        
        //        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.3
                         animations:^{
                             CGRect rt = self.view.frame;
                             rt.size.height = sz.height - yPos;
                             self.view.frame = rt;
                             
                             [self.view layoutIfNeeded];
                         }completion:^(BOOL finished) {
//                             [self scrollToBottomAnimated:YES];
                         }];
    }
}

#pragma mark - KeyBoard notifications
- (void)keyboardWillShow:(NSNotification*)notify {
    CGRect rtKeyBoard = [(NSValue*)[notify.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [self animationView:rtKeyBoard.size.height];
}

- (void)keyboardWillHide:(NSNotification*)notify {
    [self animationView:0];
}


@end
