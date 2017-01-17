//
//  ChatViewController.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"
#import "PCBorderView.h"
#import "PHTextHelper.h"

@interface ChatViewController () {
    NSString *mstrCellId;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet PCBorderView *mViewInput;
@property (weak, nonatomic) IBOutlet UITextField *mTextInput;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // nav bar
    [self showTitle:YES];
    [self initTableView:self.mTableView haveBottombar:YES];
    
    // table view
    self.mTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    // init param
    mstrCellId = @"ChatTableCell";
        
    // input view
    [self.mViewInput removeBottom];
    [PHTextHelper initTextRegular:self.mTextInput];
    
    // keyboard event
    [self enableKeyboardNotification];
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
 scroll to the bottom of the table view
 @param animated <#animated description#>
 */
- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.mTableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [self.mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                               atScrollPosition:UITableViewScrollPositionBottom
                                       animated:animated];
    }
}



/**
 make and fill contents for cell
 @param tableView <#tableview description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (ChatCell *)configureChatCell:(UITableView *)tableView index:(NSInteger)index {
    ChatCell *cellChat = (ChatCell *)[tableView dequeueReusableCellWithIdentifier:mstrCellId];
    
    if (index == 0) {
        [cellChat showTime:YES];
    }
    else if (index == 1) {
        [cellChat showTime:NO];
    }
    
    return cellChat;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatCell *cellChat = [self configureChatCell:tableView index:indexPath.row];;
    
    return cellChat;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cellChat = [self configureChatCell:tableView index:indexPath.row];;
    double dHeight = [cellChat.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    return dHeight;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [textField setText:@""];
    
    return YES;
}


@end
