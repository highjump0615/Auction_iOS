//
//  UploadCategoryViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UploadCategoryViewController.h"
#import "UploadInputViewController.h"
#import "PHTextHelper.h"
#import "UploadCategoryCell.h"
#import "CategoryData.h"

@interface UploadCategoryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation UploadCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title
    [self.mLblTitle setFont:[PHTextHelper myriadProRegular:14]];

    // remove separator of the empty cell
    [self.mTableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView.bounds.size.width, 0.01f)]];
    [self.mTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mTableView.bounds.size.width, 0.01f)]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CategoryData getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get category
    CategoryData *ct = [CategoryData getItem:indexPath.row];
    
    // fill data
    UploadCategoryCell *cellCategory = (UploadCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"UploadCategoryCell"];
    [cellCategory fillContent:ct];
    
    return cellCategory;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // send category to back page
    UploadInputViewController *viewController = (UploadInputViewController *)self.delegate;
    viewController.mCategory = [CategoryData getItem:indexPath.row];
    
    // back to prev page
    [self.navigationController popViewControllerAnimated:YES];
}


@end
