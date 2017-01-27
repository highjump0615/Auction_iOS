//
//  ApiClientCore.h
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiClientCore : NSObject

+ (ApiClientCore *)sharedInstance;

- (void)sendToServiceByPost:(NSString *)serviceApiUrl
                     params:(NSDictionary *)params
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail;

@end
