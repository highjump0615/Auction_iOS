//
//  CategoryViewController.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryViewController.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"
#import "PHUiHelper.h"
#import "CategoryExploreCell.h"
#import "ItemCollectionCell.h"
#import "CommonUtils.h"
#import "CategoryCell.h"
#import "CategoryDetailViewController.h"
#import "CategoryData.h"

@interface CategoryViewController () <UITextFieldDelegate> {
    UIRefreshControl *mRefreshControl;
    
    double dCategoryHeight;
    double dExploreHeight;
    double dExploreWidth;
    double dTitleHeight;
    
    CategoryData *mCategorySelected;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide back button
    [self showSearch:YES showBack:NO];

    // table view
    [self initTableView:self.mTableView haveBottombar:YES];
    
    // Pull to refresh
    mRefreshControl = [[UIRefreshControl alloc] init];
    [mRefreshControl addTarget:self action:@selector(loadItem:) forControlEvents:UIControlEventValueChanged];
    [self.mTableView addSubview:mRefreshControl];
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // init parameter
    dCategoryHeight = 100;
    dExploreHeight = 100;
    dExploreWidth = 100;
    dTitleHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 load items from api
 @param sender <#sender description#>
 */
- (void)loadItem:(UIRefreshControl *)sender {
    
    if (sender) { // refreshing
    }
    
    // todo: add api
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(waitThread:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) waitThread:(NSTimer*)theTimer {
    [self stopRefresh];
}

- (void)stopRefresh {
    [mRefreshControl endRefreshing];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"Category2Detail"]) {
        CategoryDetailViewController *view = (CategoryDetailViewController *)[segue destinationViewController];
        view.mCategory = mCategorySelected;
    }
}


#pragma mark - UITableViewDataSource

/**
 Explore & Categories
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Explore in default
    NSInteger nCount = 1;
    
    // Categories
    if (section == 1) {
        nCount = [CategoryData getCount];
    }
    
    return nCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Explore
    if (indexPath.section == 0) {
        CategoryExploreCell *cellExplore = (CategoryExploreCell *)[tableView dequeueReusableCellWithIdentifier:@"CateExplrCell"];
        cell = cellExplore;
    }
    // Categories
    else {
        // get category
        CategoryData *ct = [CategoryData getItem:indexPath.row];
        
        // fill data
        CategoryCell * cellCategory = [tableView dequeueReusableCellWithIdentifier:@"CateCateCell"];
        [cellCategory fillContent:ct];
        
        cell = cellCategory;
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
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, dTitleHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([PHUiHelper marginLeftNormal], 0, tableView.frame.size.width, dTitleHeight)];
    [label setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    [label setTextColor:[PHColorHelper colorTextBlack]];
    
    if (section == 0) {
        [label setText:@"Explore"];
    }
    else {
        [label setText:@"Categories"];
    }
    
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return dTitleHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Explore in default
    double dHeight = dExploreHeight;
    
    // Categories
    if (indexPath.section == 1) {
        dHeight = dCategoryHeight;
    }
    
    return dHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // get category
    CommonUtils *utils = [CommonUtils sharedObject];
    CategoryData *ct = utils.maryCategory[indexPath.row];
    
    mCategorySelected = ct;
    
    [self performSegueWithIdentifier:@"Category2Detail" sender:nil];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCollectionCell *cell = (ItemCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CateItemCell" forIndexPath:indexPath];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(dExploreWidth, dExploreHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // go to auction page
    [self performSegueWithIdentifier:@"Category2Bid" sender:nil];
}




@end
