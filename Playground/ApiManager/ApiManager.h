//
//  ApiManager.h
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

@property (nonatomic, retain) NSString *apiToken;

+ (ApiManager *)sharedInstance;
+ (NSInteger)getStatusCode:(NSError *)error;

- (void)userSigninwithUsername:(NSString *)username
                      password:(NSString *)password
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail;

@end
