//
//  PSUploadView.m
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "PCUploadView.h"
#import "PHColorHelper.h"

@interface PCUploadView()

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

+ (id)getView {
    return [super getView:@"PCUploadView"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mViewPhoto.layer setBorderWidth:0.5f];
    [self.mViewPhoto.layer setBorderColor:[PHColorHelper colorTextGray].CGColor];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.mViewPhoto.layer setMasksToBounds:YES];
    [self.mViewPhoto.layer setCornerRadius:frame.size.height / 2.0];
}


@end
