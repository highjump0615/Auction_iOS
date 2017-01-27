//
//  ApiClientCore.h
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#define MEDIA_NAME_KEY      @"name"
#define MEDIA_DATA_KEY      @"data"

#import <Foundation/Foundation.h>

@interface ApiClientCore : NSObject

+ (ApiClientCore *)sharedInstance;

- (void)sendToServiceByPost:(NSString *)serviceApiUrl
                     params:(NSDictionary *)params
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail;

- (void)sendToServiceByPost:(NSString *)serviceApiUrl
                     params:(NSDictionary *)params
                      media:(NSArray *)aryMedia
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail;


@end
