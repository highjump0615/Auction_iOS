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
#import "PHUiHelper.h"
#import "CategoryData.h"

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
    
    [self initTableView:self.mTableView haveBottombar:YES];
    
    // text & keyboard
    [self setSearchDelegate:self];
    [self setGestureRecognizer];
    
    // init param
    mdCellHeight = 120;
    mdTitleHeight = 70;
    mdSearchHeight = 55;
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
        dHeight += mdSearchHeight;
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
    double dMarginTop = 20;
    NSString *strTitle = self.mCategory.name;
    
    // if search, more content in title
    if ([self getSearchString].length > 0) {
        strTitle = @"Search";
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, dHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([PHUiHelper marginLeftNormal],
                                                               dMarginTop,
                                                               tableView.frame.size.width,
                                                               mdTitleHeight - dMarginTop)];
    [label setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    [label setTextColor:[PHColorHelper colorTextBlack]];
    [label setText:strTitle];
    [view addSubview:label];
    
    // if search, more content in title
    if ([self getSearchString].length > 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake([PHUiHelper marginLeftNormal],
                                                          mdTitleHeight,
                                                          tableView.frame.size.width,
                                                          mdSearchHeight)];
        [label setFont:[PHTextHelper myriadProBold:[PHTextHelper fontSizeLarge]]];
        [label setTextColor:[PHColorHelper colorTextGray]];
        [label setText:[self getSearchString]];
        [label sizeToFit];
        [view addSubview:label];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self getHeaderHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return mdCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // go to detail page
    [self performSegueWithIdentifier:@"CategoryDetail2Bid" sender:nil];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    
    [self.mTableView reloadData];
    
    return YES;
}


@end
