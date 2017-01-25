//
//  CategoryDetailViewController.h
//  Playground
//
//  Created by Top1 on 1/14/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseViewController.h"

@class CategoryData;

@interface CategoryDetailViewController : BaseViewController

@property (nonatomic, strong) CategoryData *mCategory;
@property (nonatomic, strong) NSString *mstrSearch;

@end
