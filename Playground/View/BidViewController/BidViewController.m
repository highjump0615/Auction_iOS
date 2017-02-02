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
#import "BidNoCommentCell.h"
#import "BidPhotoCollectionCell.h"
#import "PHTextHelper.h"
#import "PHUiHelper.h"
#import "ItemData.h"
#import "BidInputViewController.h"
#import "ApiManager.h"
#import "CommentData.h"

#define BID_TAB_DESCRIPTION     0
#define BID_TAB_PHOTO           1
#define BID_TAB_COMMENT         2

@interface BidViewController () <UITextFieldDelegate> {
    int mnSelectedTab;
    NSInteger mnSelectedComment;
    
    NSMutableArray *maryComment;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableview;
@property (weak, nonatomic) IBOutlet PCBorderView *mViewInput;
@property (weak, nonatomic) IBOutlet UITextField *mTextInput;
@property (weak, nonatomic) IBOutlet UIButton *mButComment;

@end

@implementation BidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init param
    mnSelectedTab = BID_TAB_DESCRIPTION;
    maryComment = [[NSMutableArray alloc] init];
    
    // hide back button
    [self showSearch:YES showBack:YES];
    
    // table view
    [self initTableView:self.mTableview haveBottombar:NO];
    self.mTableview.estimatedRowHeight = UITableViewAutomaticDimension;
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // font
    [self.mButComment.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [PHUiHelper makeRounded:self.mButComment];
    
    // keyboard event
    [self enableKeyboardNotification];
    
    // input text field
    [PHTextHelper initTextRegular:self.mTextInput];
    
//    //
//    // call get max bid api
//    //
//    [[ApiManager sharedInstance] getMaxBidOnItem:((ItemData *)self.mItemData).id
//                                    success:^(id response)
//     {
//         ((ItemData *)self.mItemData).maxBid = [[response objectForKey:@"value"] integerValue];
//         
//         // refresh table
//         [self.mTableview reloadData];
//     }
//                                       fail:nil];
    
    //
    // call get comment api
    //
    [[ApiManager sharedInstance] getComment:((ItemData *)self.mItemData).id
                                    success:^(id response)
     {
         // clear data
         [maryComment removeAllObjects];
         
         // add item data
         NSArray *aryComment = (NSArray *)response;
         
         for (NSDictionary *dicItem in aryComment) {
             CommentData *cData = [[CommentData alloc] initWithDic:dicItem];
             
             // set parent
             NSInteger nParent = [[dicItem valueForKey:@"parent_id"] integerValue];
             for (CommentData *cmData in maryComment) {
                 if (cmData.id == nParent) {
                     cData.parent = cmData;
                 }
             }
             
             [maryComment addObject:cData];
         }
         
         // reload table
         [self.mTableview reloadData];
     }
                                       fail:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    // refresh table for update
    [self.mTableview reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Bid2BidInput"]) {
        BidInputViewController *vc = [segue destinationViewController];
        [vc setItemData:self.mItemData];
    }
}

/**
 set selected tab index in item cell
 @param value <#value description#>
 */
- (void)setSelectedTab:(int)value {
    mnSelectedTab = value;
    [self.mTableview reloadData];
    
    // if comment, show comment button
    if (mnSelectedTab == BID_TAB_COMMENT) {
        // shows comment button if only input text is hidden
        if (self.mViewInput.isHidden) {
            [self.mButComment setHidden:NO];
        }
    }
    else {
        [self.mButComment setHidden:YES];
        [self showCommentInput:NO];
    }
    
    [self.view endEditing:YES];
}

/**
 make and fill contents for cell
 @param tableView <#tableview description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (UITableViewCell *)configureCell:(UITableView *)tableView index:(NSInteger)index {
    UITableViewCell *cell;
    
    // item cell is the first
    if (index == 0) {
        BidItemCell *cellItem = (BidItemCell *)[tableView dequeueReusableCellWithIdentifier:@"BidItemCell"];
        [cellItem fillContent:self.mItemData];
        
        cellItem.delegate = self;
        
        cell = cellItem;
    }
    else {
        // other cells are determined by the selected tab
        if (mnSelectedTab == BID_TAB_DESCRIPTION) {
            BidDescCell *cellDesc = (BidDescCell *)[tableView dequeueReusableCellWithIdentifier:@"BidDescCell"];
            [cellDesc fillContent:self.mItemData];
            
            cell = cellDesc;
        }
        else if (mnSelectedTab == BID_TAB_PHOTO) {
            BidPhotoCell *cellPhoto = (BidPhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"BidPhotoCell"];
            cell = cellPhoto;
        }
        else {
            if (maryComment.count == 0) {
                // no comment notice
                cell = [tableView dequeueReusableCellWithIdentifier:@"BidNoCommentCell"];
            }
            else {
                // comment bubbles
                BidCommentCell *cellComment = (BidCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"BidCommentCell"];
                [cellComment fillContent:[maryComment objectAtIndex:index - 1]];
                
                // set reply button
                [cellComment.mButReply setTag:index - 1];
                [cellComment.mButReply addTarget:self action:@selector(onButComment:) forControlEvents:UIControlEventTouchUpInside];
                
                if (index == 1) {
                    [cellComment showTime:YES];
                }
                else {
                    [cellComment showTime:NO];
                }
                
                cell = cellComment;
            }
        }
    }
    
    return cell;
}


/**
 show/hide input view for comment
 @param show <#show description#>
 */
- (void)showCommentInput:(BOOL)show {
    //
    // set bottom margin for tableview
    //
    UIEdgeInsets edgeTable = self.mTableview.contentInset;
    
    // if show, add bottom inset
    if (self.mViewInput.isHidden && show) {
        edgeTable.bottom += self.mViewInput.bounds.size.height;
    }
    else if (!self.mViewInput.isHidden && !show) {
        edgeTable.bottom -= self.mViewInput.bounds.size.height;
    }
    
    [self.mTableview setContentInset:edgeTable];
    
    [self.mViewInput setHidden:!show];
}

- (IBAction)onButComment:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (button.currentTitle.length > 0) {
        // comment button
        [self.mTextInput setPlaceholder:@"Add Comment..."];
        mnSelectedComment = -1;
    }
    else {
        // reply button
        mnSelectedComment = button.tag;
        CommentData * cData = [maryComment objectAtIndex:mnSelectedComment];
        
        [self.mTextInput setPlaceholder:[NSString stringWithFormat:@"Reply to %@...", cData.username]];
    }
    
    [self showCommentInput:YES];
    [self.mButComment setHidden:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // item and related data, in normal case
    NSInteger nCount = 2;
    
    // different for comment list
    if (mnSelectedTab == BID_TAB_COMMENT) {
        // no comment notice cell is needed, even no comment exists
        nCount = 1 + MAX(maryComment.count, 1);
    }
    
    return nCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self configureCell:tableView index:indexPath.row];
    
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
        dHeight = 308;
    }
    else {
        // other cells are determined by the selected tab
        if (mnSelectedTab == BID_TAB_DESCRIPTION ||
            (mnSelectedTab == BID_TAB_COMMENT && maryComment.count > 0)) {
            UITableViewCell *cell = [self configureCell:tableView index:indexPath.row];
            
            // reset layout
            [cell layoutIfNeeded];
            
            dHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
        else if (mnSelectedTab == BID_TAB_COMMENT && maryComment.count == 0) {
            // no comment notice
            dHeight = 100;
        }
        else {
            dHeight = 218 + 8 + 8;
        }
    }
    
    return dHeight;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ItemData *item = (ItemData *)self.mItemData;
    return item.imagePreview.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BidPhotoCollectionCell *cell = (BidPhotoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BidPhotoCollectionCell" forIndexPath:indexPath];
    [cell fillContent:[((ItemData *)(self.mItemData)).imagePreview objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(145, 218);
}

#pragma mark - UITextFieldDelegate

- (void)addCommentData:(NSString *)comment
                parent:(CommentData *)parentData {
    // create new data
    CommentData *cData = [[CommentData alloc] initWithText:comment parent:parentData];
    
    if (parentData) {
        //
        // if replying, need to insert in its position
        //
        for (int i = 0; i < maryComment.count; i++) {
            CommentData *cmt = maryComment[i];
            if (cmt.id == parentData.id) {
                [maryComment insertObject:cData atIndex:i+1];
                break;
            }
        }
    }
    else {
        [maryComment addObject:cData];
    }
    
    // refresh table
    [self.mTableview reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];

    // hide input & show comment again
    [self.mButComment setHidden:NO];
    [self showCommentInput:NO];

    // check if it is empty
    if (textField.text.length > 0) {
        // get parent comment
        NSInteger nParent = 0;
        CommentData *cdp;
        
        if (mnSelectedComment >= 0) {
            cdp = [maryComment objectAtIndex:mnSelectedComment];
            nParent = cdp.id;
        }
        
        //
        // call add comment api
        //
        [[ApiManager sharedInstance] addComment:textField.text
                                         parent:nParent
                                           item:((ItemData *)self.mItemData).id
                                        success:^(id response)
         {
         }
                                           fail:^(NSError *error, id response)
         {
         }];
        
        [self addCommentData:textField.text parent:cdp];
        
        [textField setText:@""];
    }
    
    return YES;
}


@end
