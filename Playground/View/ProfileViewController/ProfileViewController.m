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
#import "ItemCollectionCell.h"


@interface ProfileViewController () {
    double dTitleHeight;
    double dItemHeight;
    double dItemWidth;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide back button
    [self showSearch:YES showBack:NO];
    
    [self initTableView:self.mTableView haveBottombar:YES];
    
    // init param
    dTitleHeight = 35;
    dItemWidth = 85;
    dItemHeight = 95;
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
        cell = cellUser;
    }
    // Statistics
    else if (indexPath.section == 3) {
        ProfileStatisticsCell *cellUser = (ProfileStatisticsCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileStatisticsCell"];
        cell = cellUser;
    }
    // Auction & Bid
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileItemCell"];
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width, dTitleHeight)];
    [label setFont:[PHTextHelper myriadProBold:21]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // default: Autions & Bids
    double dHeight = dItemHeight;
    
    // User
    if (indexPath.section == 0) {
        dHeight = 200;
    }
    else if (indexPath.section == 3) {
        dHeight = 148;
    }
    
    return dHeight;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionCell *cell = (ItemCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CateItemCell" forIndexPath:indexPath];
    [cell showTimeLimit:YES];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(dItemWidth, dItemHeight);
}


@end
