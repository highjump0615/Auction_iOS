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
#import "ApiManager.h"
#import "InboxData.h"

#import "RateViewController.h"


@interface InboxViewController () <UITextFieldDelegate> {
    NSMutableArray *maryData;
    NSInteger mnSelectedIndex;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblNotice;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *mViewTitle;
@property (weak, nonatomic) IBOutlet UITableView *mTableview;

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // nav bar
    [self showSearch:YES showBack:YES];
    
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    [self.mLblNotice setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // init data
    maryData = [[NSMutableArray alloc] init];
    
    // load data
    [self getInbox];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // set margin for tableview
    UIEdgeInsets edgeTable = self.mTableview.contentInset;
    edgeTable.top = 64 + self.mViewTitle.bounds.size.height;
    //    edgeTable.bottom = 50;
    [self.mTableview setContentInset:edgeTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInbox {
    //
    // call inbox api
    //
    [[ApiManager sharedInstance] getInbox:^(id response)
     {
         // clear data
         [maryData removeAllObjects];
         
         // add item data
         NSArray *aryItem = (NSArray *)response;
         
         for (NSDictionary *dicItem in aryItem) {
             InboxData *bData = [[InboxData alloc] initWithDic:dicItem];
             [maryData addObject:bData];
             
             [self.mLblNotice setHidden:YES];
         }
         
         // reload table
         [self.mTableview reloadData];
     }
                                       fail:^(NSError *error, id response)
     {
     }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Inbox2Rate"]) {
        RateViewController *vc = (RateViewController *)[segue destinationViewController];
        InboxData *inbox = [maryData objectAtIndex:mnSelectedIndex];
        [vc setItemData:inbox.item];
    }
}


- (IBAction)onButEdit:(id)sender {
    [self.mTableview setEditing:!self.mTableview.editing animated:YES];
}


/**
 rate button in each inbox cell was clicked
 @param sender <#sender description#>
 */
- (void)onButRate:(id)sender {
    mnSelectedIndex = ((UIButton *)sender).tag;
    
    // go to rate page
    [self performSegueWithIdentifier:@"Inbox2Rate" sender:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return maryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InboxData *inbox = [maryData objectAtIndex:indexPath.row];

    InboxCell *cellInbox = (InboxCell *)[tableView dequeueReusableCellWithIdentifier:@"InboxCell"];
    [cellInbox fillContent:inbox.item];
    
    // set rate
    cellInbox.mButRate.tag = indexPath.row;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // delete button
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        InboxData *inbox = [maryData objectAtIndex:indexPath.row];
        
        //
        // call delete inbox api
        //
        [[ApiManager sharedInstance] deleteInboxWithId:inbox.id
                                               success:^(id response)
         {
         }
                                                  fail:^(NSError *error, id response)
         {
         }];
        
        //
        // delete from list with animation
        //
        NSArray *aryIndexPath = [[NSArray alloc] initWithObjects:
                                 [NSIndexPath indexPathForRow:indexPath.row inSection:0],
                                 nil];
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:aryIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // remove object from array
        [maryData removeObject:inbox];
        
        [tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // go to chat page
//    [self performSegueWithIdentifier:@"Inbox2Chat" sender:nil];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


@end
