//
//  ApiClientCore.m
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ApiClientCore.h"
#import <AFNetworking/AFNetworking.h>

@implementation ApiClientCore

+ (ApiClientCore *)sharedInstance {
    static ApiClientCore *apiClient = nil;
    if (!apiClient) {
        apiClient = [[ApiClientCore alloc] init];
    }
    
    return apiClient;
}

/**
 http post communication

 @param serviceApiUrl <#serviceApiUrl description#>
 @param params <#params description#>
 @param sucess <#sucess description#>
 @param fail <#fail description#>
 */
- (void)sendToServiceByPost:(NSString *)serviceApiUrl
                     params:(NSDictionary *)params
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // post request
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:serviceApiUrl
                                                                                parameters:params
                                                                                     error:nil];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
            // fail callback
            fail(error, responseObject);
        }
        else {
            // success callback
            sucess(responseObject);
        }
    }];
    [dataTask resume];
    
}

@end
