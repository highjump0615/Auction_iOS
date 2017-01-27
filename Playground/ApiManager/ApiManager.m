//
//  ApiManager.m
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import "ApiManager.h"
#import "ApiClientCore.h"
#import "ApiConfig.h"
#import <AFNetworking/AFNetworking.h>

@implementation ApiManager

+ (ApiManager *)sharedInstance {
    static ApiManager *apiManager = nil;
    if (!apiManager) {
        apiManager = [[ApiManager alloc] init];
    }
    
    return apiManager;
}

+ (NSInteger)getStatusCode:(NSError *)error {
    NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    
    return response.statusCode;
}


- (void)userSigninwithUsername:(NSString *)username
                      password:(NSString *)password
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_LOGIN];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:username forKey:@"username"];
    [dictParam setObject:password forKey:@"password"];
    
    // call web service
    [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                 params:dictParam
                                                success:sucess
                                                   fail:fail];
}

@end
