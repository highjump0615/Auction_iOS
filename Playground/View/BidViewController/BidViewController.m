//
//  BidViewController.m
//  Playground
//
//  Created by Top1 on 1/16/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BidViewController.h"
#import "PCBorderView.h"
#import "BidItemCell.h"
#import "BidDescCell.h"
#import "BidPhotoCell.h"
#import "BidCommentCell.h"
#import "BidPhotoCollectionCell.h"

#define BID_TAB_DESCRIPTION     0
#define BID_TAB_PHOTO           1
#define BID_TAB_COMMENT         2

@interface BidViewController () {
    int mnSelectedTab;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableview;
@property (weak, nonatomic) IBOutlet PCBorderView *mViewInput;
@property (weak, nonatomic) IBOutlet UIButton *mButComment;

@end

@implementation BidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init param
    mnSelectedTab = BID_TAB_DESCRIPTION;
    
    // table view
    self.mTableview.estimatedRowHeight = UITableViewAutomaticDimension;
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
 set selected tab index in item cell
 @param value <#value description#>
 */
- (void)setSelectedTab:(int)value {
    mnSelectedTab = value;
    [self.mTableview reloadData];
}

/**
 make and fill contents for cell
 @param tableView <#tableview description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (UITableViewCell *)configureChatCell:(UITableView *)tableView index:(NSInteger)index {
    UITableViewCell *cell;
    
    // item cell is the first
    if (index == 0) {
        BidItemCell *cellItem = (BidItemCell *)[tableView dequeueReusableCellWithIdentifier:@"BidItemCell"];
        cell = cellItem;
    }
    else {
        // other cells are determined by the selected tab
        if (mnSelectedTab == BID_TAB_DESCRIPTION) {
            BidDescCell *cellDesc = (BidDescCell *)[tableView dequeueReusableCellWithIdentifier:@"BidDescCell"];
            cell = cellDesc;
        }
        else if (mnSelectedTab == BID_TAB_DESCRIPTION) {
            BidPhotoCell *cellPhoto = (BidPhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"BidPhotoCell"];
            cell = cellPhoto;
        }
        else {
            BidCommentCell *cellComment = (BidCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"BidCommentCell"];
            cell = cellComment;
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // item and related data, in normal case
    int nCount = 2;
    
    // different for comment list
    if (mnSelectedTab == BID_TAB_COMMENT) {
        nCount = 1 + 2;
    }
    
    return nCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self configureChatCell:tableView index:indexPath.row];
    
    return cell;
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
    double dHeight = 0;
    
    // item cell is the first
    if (indexPath.row == 0) {
        dHeight = 266;
    }
    else {
        // other cells are determined by the selected tab
        if (mnSelectedTab == BID_TAB_DESCRIPTION || mnSelectedTab == BID_TAB_COMMENT) {
            UITableViewCell *cell = [self configureChatCell:tableView index:indexPath.row];
            dHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
        else {
            dHeight = 216;
        }
    }
    
    return dHeight;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidPhotoCollectionCell *cell = (BidPhotoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BidPhotoCollectionCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(120, 200);
}


@end
