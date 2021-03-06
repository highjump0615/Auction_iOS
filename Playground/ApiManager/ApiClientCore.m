//
//  ApiClientCore.m
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ApiClientCore.h"
#import <AFNetworking/AFNetworking.h>
#import "ApiManager.h"

@implementation ApiClientCore

+ (ApiClientCore *)sharedInstance {
    static ApiClientCore *apiClient = nil;
    if (!apiClient) {
        apiClient = [[ApiClientCore alloc] init];
    }
    
    return apiClient;
}

- (void)showLoading:(BOOL)show
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
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
    
    // set authorization bearer
    if ([ApiManager sharedInstance].apiToken) {
        [request addValue:[NSString stringWithFormat:@"Bearer %@", [ApiManager sharedInstance].apiToken] forHTTPHeaderField:@"Authorization"];
    }
    
    // show loading mark
    [self showLoading:YES];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        // hide loading mark
        [self showLoading:NO];
        
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

/**
 http post communication with uploading media

 @param serviceApiUrl <#serviceApiUrl description#>
 @param params <#params description#>
 @param sucess <#sucess description#>
 @param fail <#fail description#>
 */
- (void)sendToServiceByPost:(NSString *)serviceApiUrl
                     params:(NSDictionary *)params
                      media:(NSArray *)aryMedia
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:serviceApiUrl
                                                                                             parameters:params
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        // append image file data
        for (NSDictionary *dicMedia in aryMedia) {
            [formData appendPartWithFileData:[dicMedia valueForKey:MEDIA_DATA_KEY]
                                        name:[dicMedia valueForKey:MEDIA_NAME_KEY]
                                    fileName:@"image.jpg"
                                    mimeType:@"image/jpeg"];
        }
    }
    
                                                                                                  error:nil];

    // set json as accept
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // set authorization bearer
    if ([ApiManager sharedInstance].apiToken) {
        [request addValue:[NSString stringWithFormat:@"Bearer %@", [ApiManager sharedInstance].apiToken] forHTTPHeaderField:@"Authorization"];
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    
    // show loading mark
    [self showLoading:YES];
    
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          //Update the progress view
//                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      // hide loading mark
                      [self showLoading:NO];
                      
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
    
    [uploadTask resume];
}

/**
 HTTP get request

 @param serviceApiUrl <#serviceApiUrl description#>
 @param params <#params description#>
 @param sucess <#sucess description#>
 @param fail <#fail description#>
 */
- (void)sendToServiceByGet:(NSString *)serviceApiUrl
                    params:(NSDictionary *)params
                   success:(void (^)(id response))sucess
                      fail:(void (^)(NSError *error, id response))fail {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableDictionary *dicParam = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    // add api token to its param
    [dicParam setObject:[ApiManager sharedInstance].apiToken forKey:@"api_token"];
    
    // get request
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:serviceApiUrl
                                                                                parameters:dicParam
                                                                                     error:nil];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // show loading mark
    [self showLoading:YES];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        // hide loading mark
        [self showLoading:NO];
        
        if (error) {
            NSLog(@"Error: %@", error);
            
            if (fail) {
                // fail callback
                fail(error, responseObject);
            }
        }
        else {
            // success callback
            sucess(responseObject);
        }
    }];
    [dataTask resume];
}


@end
