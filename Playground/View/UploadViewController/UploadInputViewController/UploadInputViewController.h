//
//  UploadInputViewController.h
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"

@class CategoryData;

@interface UploadInputViewController : BaseViewController

@property (nonatomic, strong) UIImage *mImgCover;
@property (nonatomic, strong) UIImage *mImgPreview1;
@property (nonatomic, strong) UIImage *mImgPreview2;
@property (nonatomic, strong) UIImage *mImgPreview3;

@property (nonatomic, strong) CategoryData *mCategory;

@end
