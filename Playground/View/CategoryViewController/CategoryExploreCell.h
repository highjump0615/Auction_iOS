//
//  CategoryExploreCell.h
//  Playground
//
//  Created by Top1 on 1/13/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryExploreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

- (void)fillContent:(NSInteger)count;
- (void)setNoticeText:(NSString *)value;

@end
