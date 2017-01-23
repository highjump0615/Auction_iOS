//
//  PSUploadView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCUploadView.h"
#import "PHColorHelper.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface PCUploadView() {
    int mnMode;
    UIImagePickerController *mImagePicker;
}

@property (weak, nonatomic) IBOutlet UIImageView *mImgviewPhoto;
@property (weak, nonatomic) IBOutlet UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> *mViewController;

@end

@implementation PCUploadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView:(int)mode controller:(UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> *)controller {
    NSString *strName = @"PCUploadView";
    
    if (mode == UPLOAD_VIEW_BOTTOM) {
        strName = @"PCUploadViewBottom";
    }

    PCUploadView *viewUpload = [super getView:strName];
    [viewUpload setViewMode:mode];
    viewUpload.mViewController = controller;
    
    return viewUpload;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mImgviewPhoto.layer setBorderWidth:0.5f];
    [self.mImgviewPhoto.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    // make round
    [self.mImgviewPhoto.layer setMasksToBounds:YES];
    
    if (mnMode == UPLOAD_VIEW_RIGHT) {
        [self.mImgviewPhoto.layer setCornerRadius:frame.size.height / 2.0];
    }
    else {
        [self.mImgviewPhoto.layer setCornerRadius:4];
    }
}


/**
 redefine set background color
 @param backgroundColor <#backgroundColor description#>
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
    [self.mImgviewPhoto setBackgroundColor:backgroundColor];
}


/**
 set image to imageview
 @param image <#image description#>
 */
- (void)setImage:(UIImage *)image {
    [self.mImgviewPhoto setImage:image];
}

- (void)setViewMode:(int)mode {
    mnMode = mode;
}

- (UIImagePickerController *)getImagePicker {
    return mImagePicker;
}

- (IBAction)onButAdd:(id)sender {
    [self shouldStartCameraController];
}

- (BOOL)shouldStartCameraController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    mImagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        mImagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        mImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            mImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            mImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
    }
    else {
        return NO;
    }
    
    mImagePicker.allowsEditing = YES;
    mImagePicker.showsCameraControls = YES;
    mImagePicker.delegate = self.mViewController;
    
    [self.mViewController presentViewController:mImagePicker animated:YES completion:nil];
    
    return YES;
}


@end
