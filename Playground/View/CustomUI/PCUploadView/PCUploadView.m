//
//  PSUploadView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCUploadView.h"
#import "PHColorHelper.h" 

@interface PCUploadView() {
    int mnMode;
}

@property (weak, nonatomic) IBOutlet UIView *mViewPhoto;

@end

@implementation PCUploadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView:(int)mode {
    NSString *strName = @"PCUploadView";
    
    if (mode == UPLOAD_VIEW_BOTTOM) {
        strName = @"PCUploadViewBottom";
    }

    PCUploadView *viewUpload = [super getView:strName];
    [viewUpload setViewMode:mode];
    
    return viewUpload;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mViewPhoto.layer setBorderWidth:0.5f];
    [self.mViewPhoto.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (mnMode == UPLOAD_VIEW_RIGHT) {
        [self.mViewPhoto.layer setMasksToBounds:YES];
        [self.mViewPhoto.layer setCornerRadius:frame.size.height / 2.0];
    }
}

- (void)setViewMode:(int)mode {
    mnMode = mode;
}


@end
