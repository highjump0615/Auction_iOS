//
//  ProfileViewController.m
//  Playground
//
//  Created by Top1 on 1/15/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileUserCell.h"
#import "ProfileStatisticsCell.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"
#import "ItemCollectionCell.h"
#import "ApiManager.h"
#import "UserData.h"
#import "CategoryExploreCell.h"
#import "ItemData.h"
#import "BidViewController.h"
#import "AuctionViewController.h"

@interface ProfileViewController () <UITextFieldDelegate> {
    double dTitleHeight;
    double dItemHeight;
    double dItemWidth;
    
    UICollectionView *mCVauction;
    UICollectionView *mCVbid;
    
    ItemData *mItemSelected;
    NSTimer *mTimerItem;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide back button
    [self showSearch:YES showBack:NO];
    
    [self initTableView:self.mTableView haveBottombar:NO];
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // init param
    dTitleHeight = 52;
    dItemWidth = 100;
    dItemHeight = 108;
    
    // load data
    [self getUserInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // show tab bar
    [self.tabBarController.tabBar setHidden:NO];
    
    // refresh table
    [self.mTableView reloadData];
    
    //
    // timer for updating timeout
    //
    mTimerItem = [NSTimer scheduledTimerWithTimeInterval:30
                                                  target:self
                                                selector:@selector(updateItem:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    // stop timer
    [mTimerItem invalidate];
}

- (void)updateItem:(id)sender {
    [self.mTableView reloadData];
    
    NSLog(@"updating item in profile view");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Profile2Bid"]) {
        BidViewController *vc = [segue destinationViewController];
        vc.mItemData = mItemSelected;
    }
    else if ([[segue identifier] isEqualToString:@"Profile2Auction"]) {
        AuctionViewController *vc = [segue destinationViewController];
        vc.mItemData = mItemSelected;
    }
}


- (void)getUserInfo {
    //
    // call login api
    //
    [[ApiManager sharedInstance] getUserInfo:^(id response)
     {
         // set data of the user
         UserData *user = [UserData currentUser];
         [user fetchAuctionItems:[response objectForKey:@"auctions"]];
         [user fetchBidItems:[response objectForKey:@"bids"]];
         
         // reload table
         [self.mTableView reloadData];
     }
                                       fail:^(NSError *error, id response)
     {
     }];
}

#pragma mark - UITableViewDataSource

/**
 User, Acution, Bids, Statistics
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // User
    if (indexPath.section == 0) {
        ProfileUserCell *cellUser = (ProfileUserCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileUserCell"];
        [cellUser fillContent:[UserData currentUser]];
        
        cell = cellUser;
    }
    // Statistics
    else if (indexPath.section == 3) {
        ProfileStatisticsCell *cellUser = (ProfileStatisticsCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileStatisticsCell"];
        [cellUser fillContent:[UserData currentUser]];
        
        cell = cellUser;
    }
    // Auction & Bid
    else {
        CategoryExploreCell *cellItem = (CategoryExploreCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileItemCell"];
        
        UserData *user = [UserData currentUser];
        
        // auction
        if (indexPath.section == 1) {
            [cellItem fillContent:user.auctionItems.count];
            [cellItem setNoticeText:@"No auction items available."];
            mCVauction = cellItem.mCollectionView;
        }
        // bid
        else if (indexPath.section == 2) {
            [cellItem fillContent:user.bidItems.count];
            [cellItem setNoticeText:@"No bid items available."];
            mCVbid = cellItem.mCollectionView;
        }
        
        cell = cellItem;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

/**
 set title view of each section
 @param tableView <#tableView description#>
 @param section index
 @return <#return value description#>
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // no title for user section
    if (section == 0) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, dTitleHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([PHUiHelper marginLeftNormal], 0, tableView.frame.size.width, dTitleHeight)];
    [label setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeNormalLarge]]];
    [label setTextColor:[PHColorHelper colorTextBlack]];
    
    if (section == 1) {
        [label setText:@"Auctions"];
    }
    else if (section == 2) {
        [label setText:@"Bids"];
    }
    else if (section == 3) {
        [label setText:@"Statistics"];
    }
    
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // no title for user section
    if (section == 0) {
        return 0;
    }
    
    return dTitleHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // default: Autions & Bids
    double dHeight = dItemHeight;
    
    // User
    if (indexPath.section == 0) {
        dHeight = 225;
    }
    else if (indexPath.section == 3) {
        dHeight = 148;
    }
    
    return dHeight;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    UserData *user = [UserData currentUser];
    NSInteger nCount;
    
    if ([collectionView isEqual:mCVauction]) {
        nCount = user.auctionItems.count;
    }
    else {
        nCount = user.bidItems.count;
    }
    
    return nCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionCell *cell = (ItemCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CateItemCell" forIndexPath:indexPath];
    
    UserData *user = [UserData currentUser];
    if ([collectionView isEqual:mCVauction]) {
        [cell fillContent:[user.auctionItems objectAtIndex:indexPath.row]];
    }
    else {
        [cell fillContent:[user.bidItems objectAtIndex:indexPath.row]];
    }
    [cell showTimeLimit:YES];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(dItemWidth, dItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserData *user = [UserData currentUser];
    
    if ([collectionView isEqual:mCVauction]) {
        mItemSelected = [user.auctionItems objectAtIndex:indexPath.row];
    }
    else {
        mItemSelected = [user.bidItems objectAtIndex:indexPath.row];
    }
    
    // determine where to go
    if ([mItemSelected availableToBid]) {
        // go to bid page
        [self performSegueWithIdentifier:@"Profile2Bid" sender:nil];
    }
    else {
        // go to auction page
        [self performSegueWithIdentifier:@"Profile2Auction" sender:nil];
    }
}

@end
