//
//  MainTabbarController.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set image with original rendering mode
    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
    item.image = [[UIImage imageNamed:@"tab_category"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item = [self.tabBar.items objectAtIndex:1];
    item.image = [[UIImage imageNamed:@"tab_oval"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item = [self.tabBar.items objectAtIndex:2];
    item.image = [[UIImage imageNamed:@"tab_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

@end
