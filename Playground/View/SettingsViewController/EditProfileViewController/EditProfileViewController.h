//
//  EditProfileViewController.h
//  Playground
//
//  Created by Top1 on 1/18/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"

@class PCTextField;

@interface EditProfileViewController : BaseViewController

@property (weak, nonatomic) IBOutlet PCTextField *mTxtName;
@property (weak, nonatomic) IBOutlet PCTextField *mTxtUsername;

- (void)initTextField:(UITextField *)textfield;

@end
