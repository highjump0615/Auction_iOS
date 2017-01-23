//
//  MainTabbarController.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController () <UITabBarControllerDelegate>

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set image with original rendering mode
    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
    item.image = [[UIImage imageNamed:@"tab_category"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self updateUploadTabbarItem];
    
    item = [self.tabBar.items objectAtIndex:2];
    item.image = [[UIImage imageNamed:@"tab_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *aryViewControllers = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    
    // if upload tab doesn't exist, add it
    if (aryViewControllers.count < 3) {
        // restore tabbar items
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vcUpload = [storyBoard instantiateViewControllerWithIdentifier:@"Upload"];
        [aryViewControllers insertObject:vcUpload atIndex:1];
        
        [self setViewControllers:aryViewControllers];
        
        // update icon again
        [self updateUploadTabbarItem];
    }
}

/**
 set upload tab bar item icon
 */
- (void)updateUploadTabbarItem {
    UITabBarItem *item = [self.tabBar.items objectAtIndex:1];
    item.image = [[UIImage imageNamed:@"tab_oval"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    
    // if selecting upload tab item
    if ([viewController isEqual:self.viewControllers[1]]) {
        // go to upload page manually
        [self.navigationController pushViewController:viewController animated:YES];
        
        return NO;
    }
    
    return YES;
}

@end
