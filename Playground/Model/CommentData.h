//
//  CommentData.h
//  Playground
//
//  Created by Top1 on 1/30/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "BaseModelData.h"

@interface CommentData : BaseModelData

@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) CommentData *parent;
@property (nonatomic, retain) NSDate *createdAt;

- (id)initWithDic:(NSDictionary *)data;
- (id)initWithText:(NSString *)comment parent:(CommentData *)parent;

@end
