//
//  UploadViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UploadViewController.h"
#import "PHTextHelper.h"
#import "PCUploadView.h"
#import "PHUiHelper.h"

@interface UploadViewController () {
    PCUploadView *mViewUploadCoverCore;
    NSMutableArray *maryViewUploadPreview;
}

@property (weak, nonatomic) IBOutlet UILabel *mLblTitle;

@property (weak, nonatomic) IBOutlet UILabel *mLblCover;
@property (weak, nonatomic) IBOutlet UIView *mViewUploadCover;

@property (weak, nonatomic) IBOutlet UILabel *mLblPreview;
@property (weak, nonatomic) IBOutlet UIView *mViewUploadPreview1;
@property (weak, nonatomic) IBOutlet UIView *mViewUploadPreview2;
@property (weak, nonatomic) IBOutlet UIView *mViewUploadPreview3;

@property (weak, nonatomic) IBOutlet UILabel *mLblRequire;
@property (weak, nonatomic) IBOutlet UIButton *mButNext;

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // font
    [self.mLblTitle setFont:[PHTextHelper myriadProBold:35]];
    [self.mLblCover setFont:[PHTextHelper myriadProRegular:14]];
    [self.mLblPreview setFont:[PHTextHelper myriadProRegular:14]];
    [self.mLblRequire setFont:[PHTextHelper myriadProRegular:12]];
    [self.mButNext.titleLabel setFont:[PHTextHelper myriadProRegular:14]];
    
    // add upload cover
    mViewUploadCoverCore = [PCUploadView getView:UPLOAD_VIEW_RIGHT];
    mViewUploadCoverCore.frame = self.mViewUploadCover.bounds;
    [self.mViewUploadCover addSubview:mViewUploadCoverCore];
    
    // add photo upload view
    maryViewUploadPreview = [[NSMutableArray alloc] init];
    [maryViewUploadPreview addObject:self.mViewUploadPreview1];
    [maryViewUploadPreview addObject:self.mViewUploadPreview2];
    [maryViewUploadPreview addObject:self.mViewUploadPreview3];
    
    for (UIView *view in maryViewUploadPreview) {
        PCUploadView *viewUpload = [PCUploadView getView:UPLOAD_VIEW_BOTTOM];
        viewUpload.frame = view.bounds;
        [view addSubview:viewUpload];
    }
    
    // next button
    [PHUiHelper makeRounded:self.mButNext];
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
