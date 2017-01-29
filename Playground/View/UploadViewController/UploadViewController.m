//
//  UploadViewController.m
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "UploadViewController.h"
#import "UploadInputViewController.h"
#import "PHTextHelper.h"
#import "PCUploadView.h"
#import "PHUiHelper.h"

@interface UploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    PCUploadView *mViewUploadCoverCore;
    NSMutableArray *maryViewUploadPreview;
    NSMutableArray *maryViewUploadPreviewCore;
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
    [self.mLblTitle setFont:[PHTextHelper myriadProBlack:[PHTextHelper fontSizeLarge]]];
    [self.mLblCover setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblPreview setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    [self.mLblRequire setFont:[PHTextHelper myriadProRegular:12]];
    [self.mButNext.titleLabel setFont:[PHTextHelper myriadProRegular:[PHTextHelper fontSizeNormal]]];
    
    // add upload cover
    mViewUploadCoverCore = [PCUploadView getView:UPLOAD_VIEW_RIGHT controller:self];
    mViewUploadCoverCore.frame = self.mViewUploadCover.bounds;
    [mViewUploadCoverCore setBackgroundColor:[UIColor clearColor]];
    [self.mViewUploadCover addSubview:mViewUploadCoverCore];
    
    // add photo upload view
    maryViewUploadPreview = [[NSMutableArray alloc] init];
    maryViewUploadPreviewCore = [[NSMutableArray alloc] init];
    
    [maryViewUploadPreview addObject:self.mViewUploadPreview1];
    [maryViewUploadPreview addObject:self.mViewUploadPreview2];
    [maryViewUploadPreview addObject:self.mViewUploadPreview3];
    
    for (UIView *view in maryViewUploadPreview) {
        PCUploadView *viewUpload = [PCUploadView getView:UPLOAD_VIEW_BOTTOM controller:self];
        viewUpload.frame = view.bounds;
        [viewUpload setBackgroundColor:[UIColor clearColor]];
        [view addSubview:viewUpload];
        
        [maryViewUploadPreviewCore addObject:viewUpload];
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

- (IBAction)onButNext:(id)sender {
    // check data validitiy
    UIImage *imgCover = [mViewUploadCoverCore getImage];
    if (!imgCover) {
        [PHUiHelper showAlertView:self message:@"Cover photo is required"];
        return;
    }
    
    // set preview
    int nCount = 0;
    UploadInputViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UploadInputViewController"];
    
    UIImage *imgPreview = [maryViewUploadPreviewCore[0] getImage];
    if (imgPreview) {
        vc.mImgPreview1 = imgPreview;
        nCount++;
    }
    
    imgPreview = [maryViewUploadPreviewCore[1] getImage];
    if (imgPreview) {
        vc.mImgPreview2 = imgPreview;
        nCount++;
    }
    
    imgPreview = [maryViewUploadPreviewCore[2] getImage];
    if (imgPreview) {
        vc.mImgPreview3 = imgPreview;
        nCount++;
    }
    
    // if no preview image selected, abort
    if (nCount == 0) {
        [PHUiHelper showAlertView:self message:@"At least 1 preview photo is required"];
        return;
    }

    // set cover photo
    vc.mImgCover = imgCover;
    
    // go to next page
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // get image
    UIImage *imgRes = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if ([mViewUploadCoverCore getImagePicker] == picker) {
        [mViewUploadCoverCore setImage:imgRes];
    }
    
    for (PCUploadView *viewUpload in maryViewUploadPreviewCore) {
        if ([viewUpload getImagePicker] == picker) {
            [viewUpload setImage:imgRes];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
