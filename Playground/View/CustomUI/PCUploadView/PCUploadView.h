//
//  PSUploadView.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCBaseView.h"

#define UPLOAD_VIEW_RIGHT   0
#define UPLOAD_VIEW_BOTTOM  1

@interface PCUploadView : PCBaseView

+ (id)getView:(int)mode controller:(UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> *)controller;

- (void)setFrame:(CGRect)frame;
- (void)setImage:(UIImage *)image;

@end
