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

    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
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

@end
