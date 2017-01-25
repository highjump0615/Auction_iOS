//
//  InboxViewController.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "InboxViewController.h"
#import "InboxCell.h"
#import "PHTextHelper.h"

@interface InboxViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *mViewTitle;
@property (weak, nonatomic) IBOutlet UITableView *mTableview;

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set margin for tableview
    UIEdgeInsets edgeTable = self.mTableview.contentInset;
    edgeTable.top = 44 + self.mViewTitle.bounds.size.height;
//    edgeTable.bottom = 50;
    [self.mTableview setContentInset:edgeTable];
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // nav bar
    [self showSearch:YES showBack:YES];
    
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
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

- (IBAction)onButEdit:(id)sender {
    [self.mTableview setEditing:!self.mTableview.editing animated:YES];
}


/**
 rate button in each inbox cell was clicked
 @param sender <#sender description#>
 */
- (void)onButRate:(id)sender {
    // go to rate page
    [self performSegueWithIdentifier:@"Inbox2Rate" sender:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InboxCell *cellInbox = (InboxCell *)[tableView dequeueReusableCellWithIdentifier:@"InboxCell"];
    [cellInbox.mButRate addTarget:self action:@selector(onButRate:) forControlEvents:UIControlEventTouchUpInside];

    return cellInbox;
}

/**
 use for enable delete
 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // go to rate page
    [self performSegueWithIdentifier:@"Inbox2Chat" sender:nil];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


@end
