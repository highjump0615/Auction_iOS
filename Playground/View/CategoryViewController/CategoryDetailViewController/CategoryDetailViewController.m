//
//  CategoryDetailViewController.m
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "CategoryDetailCell.h"
#import "PHTextHelper.h"
#import "PHColorHelper.h"


@interface CategoryDetailViewController () <UITextFieldDelegate>  {
    double mdCellHeight;
    double mdTitleHeight;
    double mdSearchHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation CategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // show search on nav bar
    [self showSearch:YES showBack:YES];
    [self setSearchDelegate:self];
    
    [self initTableView:self.mTableView];
    
    // init param
    mdCellHeight = 100;
    mdTitleHeight = 50;
    mdSearchHeight = 30;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CategoryDetailCell *cellDetail = (CategoryDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"CateDetailCell"];
    
    return cellDetail;
}

#pragma mark - UITableViewDelegate


/**
 calc header height
 @return <#return value description#>
 */
- (double)getHeaderHeight {
    double dHeight = mdTitleHeight;
    
    if ([self getSearchString].length > 0) {
        dHeight += mdTitleHeight;
    }
    
    return dHeight;
}

/**
 set title view of the table
 @param tableView <#tableView description#>
 @param section index
 @return <#return value description#>
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    double dHeight = [self getHeaderHeight];
    NSString *strTitle = @"For Him";
    
    // if search, more content in title
    if ([self getSearchString].length > 0) {
        strTitle = @"Search";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, dHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, mdTitleHeight)];
    [label setFont:[PHTextHelper myriadProBold:35]];
    [label setTextColor:[PHColorHelper colorTextBlack]];
    [label setText:strTitle];
    [view addSubview:label];
    
    // if search, more content in title
    if ([self getSearchString].length > 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, mdTitleHeight, tableView.frame.size.width, mdSearchHeight)];
        [label setFont:[PHTextHelper myriadProBold:35]];
        [label setTextColor:[PHColorHelper colorTextGray]];
        [label setText:[self getSearchString]];
        [view addSubview:label];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self getHeaderHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return mdCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self.mTableView reloadData];
    
    return YES;
}


@end
