//
//  EditNotificationViewController.m
//  Playground
//
//  Created by Top1 on 1/19/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "EditNotificationViewController.h"
#import "PHTextHelper.h"

@interface EditNotificationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *mLblWon;
@property (weak, nonatomic) IBOutlet UILabel *mLblLost;
@property (weak, nonatomic) IBOutlet UILabel *mLblLastHour;
@property (weak, nonatomic) IBOutlet UILabel *mLblReceive;
@property (weak, nonatomic) IBOutlet UILabel *mLblTransfer;

@end

@implementation EditNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // font
    double dFontSize = 14;
    
    [self.mLblTitle setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblWon setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblLost setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblLastHour setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblReceive setFont:[PHTextHelper myriadProRegular:dFontSize]];
    [self.mLblTransfer setFont:[PHTextHelper myriadProRegular:dFontSize]];
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
