//
//  CategoryCell.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryData;

@interface CategoryCell : UITableViewCell

- (void)fillContent:(CategoryData *)category;

@end
