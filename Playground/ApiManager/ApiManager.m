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
#import "CommonUtils.h"

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

+ (NSString *)getErrorDescription:(NSError *)error response:(id)response {
    NSString *strDesc = [error localizedDescription];
    
    if ([ApiManager getStatusCode:error] == PH_FAIL_STATE) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSArray *aryKey = [response allKeys];
            id value = [response valueForKey:aryKey[0]];
            
            if ([value isKindOfClass:[NSArray class]]) {
                strDesc = ((NSArray *)value)[0];
            }
            else if ([value isKindOfClass:[NSString class]]) {
                strDesc = value;
            }
        }
    }
    
    return strDesc;
}

/**
 save api token to local storage
 @param value <#value description#>
 */
- (void)setApiToken:(NSString *)value {
    _apiToken = value;
    
    // save to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:kApiToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 load api token from local storage
 */
- (void)loadApiToken {
    // load from NSUserDefaults
    _apiToken = [[NSUserDefaults standardUserDefaults] objectForKey:kApiToken];
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

- (void)userSignupwithUsername:(NSString *)username
                      password:(NSString *)password
                          name:(NSString *)name
                         email:(NSString *)email
                      birthday:(NSString *)birthday
                        gender:(NSInteger)gender
                         photo:(NSData *)photo
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_SIGNUP];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:username forKey:@"username"];
    [dictParam setObject:password forKey:@"password"];
    [dictParam setObject:name forKey:@"name"];
    [dictParam setObject:email forKey:@"email"];
    [dictParam setObject:[NSNumber numberWithInteger:gender] forKey:@"gender"];
    
    if (birthday) {
        [dictParam setObject:birthday forKey:@"birthday"];
    }
    
    if (photo) {
        // media param
        NSMutableArray *aryMedia = [[NSMutableArray alloc] init];
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"photo", MEDIA_NAME_KEY, photo, MEDIA_DATA_KEY, nil]];

        // call web service
        [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                     params:dictParam
                                                      media:aryMedia
                                                    success:sucess
                                                       fail:fail];
    }
    else {
        // call web service
        [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                     params:dictParam
                                                    success:sucess
                                                       fail:fail];
    }
}

- (void)getUser:(void (^)(id response))sucess
           fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_GETUSER];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                                success:sucess
                                                   fail:fail];
}

- (void)getUserInfo:(void (^)(id response))sucess
               fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_GETUSERINFO];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                               success:sucess
                                                  fail:fail];
}

- (void)uploadItemWithTitle:(NSString *)title
                description:(NSString *)desc
                   category:(NSInteger)category
                      price:(NSString *)price
                  condition:(NSInteger)condition
                     period:(NSInteger)period
                     image0:(NSData *)image0
                     image1:(NSData *)image1
                     image2:(NSData *)image2
                     image3:(NSData *)image3
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail {
    
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_UPLOAD_ITEM];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:title forKey:@"title"];
    [dictParam setObject:desc forKey:@"desc"];
    [dictParam setObject:[NSNumber numberWithInteger:category] forKey:@"category"];
    [dictParam setObject:price forKey:@"price"];
    [dictParam setObject:[NSNumber numberWithInteger:condition] forKey:@"condition"];
    [dictParam setObject:[NSNumber numberWithInteger:period] forKey:@"period"];
    
    // media param
    NSMutableArray *aryMedia = [[NSMutableArray alloc] init];
    if (image0) {
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"image0", MEDIA_NAME_KEY, image0, MEDIA_DATA_KEY, nil]];
    }
    if (image1) {
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"image1", MEDIA_NAME_KEY, image1, MEDIA_DATA_KEY, nil]];
    }
    if (image2) {
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"image2", MEDIA_NAME_KEY, image2, MEDIA_DATA_KEY, nil]];
    }
    if (image3) {
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"image3", MEDIA_NAME_KEY, image3, MEDIA_DATA_KEY, nil]];
    }
    
    // call web service
    [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                 params:dictParam
                                                  media:aryMedia
                                                success:sucess
                                                   fail:fail];
}

- (void)getExplore:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_EXPLORE];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                               success:sucess
                                                  fail:fail];
}

- (void)getCategoryItem:(NSInteger)category
                success:(void (^)(id response))sucess
                   fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@/%ld", PH_API_BASE_URL, PH_API_GETCATEGORY, (long)category];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                               success:sucess
                                                  fail:fail];
}

- (void)searchItem:(NSString *)keyword
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@/%@", PH_API_BASE_URL, PH_API_SEARCH_ITEM, keyword];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                               success:sucess
                                                  fail:fail];
}

- (void)placeBidWithPrice:(NSInteger)price
                     item:(NSInteger)itemId
                  success:(void (^)(id response))sucess
                     fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_BID_ITEM];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:[NSNumber numberWithInteger:price] forKey:@"price"];
    [dictParam setObject:[NSNumber numberWithInteger:itemId] forKey:@"item"];

    // call web service
    [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                 params:dictParam
                                                success:sucess
                                                   fail:fail];
}

- (void)getMaxBidOnItem:(NSInteger)itemId
                success:(void (^)(id response))sucess
                   fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@/%ld", PH_API_BASE_URL, PH_API_GETMAXBID, (long)itemId];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:nil
                                               success:sucess
                                                  fail:fail];
}

- (void)getComment:(NSInteger)itemId
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_GETCOMMENT];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    [dictParam setObject:[NSNumber numberWithInteger:itemId] forKey:@"item"];
    
    [[ApiClientCore sharedInstance] sendToServiceByGet:strUrl
                                                params:dictParam
                                               success:sucess
                                                  fail:fail];
}

- (void)addComment:(NSString *)comment
            parent:(NSInteger)parentId
              item:(NSInteger)itemId
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail {

    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_ADDCOMMENT];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:comment forKey:@"comment"];
    [dictParam setObject:[NSNumber numberWithInteger:parentId] forKey:@"parent"];
    [dictParam setObject:[NSNumber numberWithInteger:itemId] forKey:@"item"];
    
    // call web service
    [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                 params:dictParam
                                                success:sucess
                                                   fail:fail];
}

- (void)saveProfilewithUsername:(NSString *)username
                           name:(NSString *)name
                       birthday:(NSString *)birthday
                         gender:(NSInteger)gender
                          photo:(NSData *)photo
                        success:(void (^)(id response))sucess
                           fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_SAVEPROFILE];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:username forKey:@"username"];
    [dictParam setObject:name forKey:@"name"];
    [dictParam setObject:[NSNumber numberWithInteger:gender] forKey:@"gender"];
    
    if (birthday) {
        [dictParam setObject:birthday forKey:@"birthday"];
    }
    
    if (photo) {
        // media param
        NSMutableArray *aryMedia = [[NSMutableArray alloc] init];
        [aryMedia addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"photo", MEDIA_NAME_KEY, photo, MEDIA_DATA_KEY, nil]];
        
        // call web service
        [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                     params:dictParam
                                                      media:aryMedia
                                                    success:sucess
                                                       fail:fail];
    }
    else {
        // call web service
        [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                     params:dictParam
                                                    success:sucess
                                                       fail:fail];
    }
}

- (void)saveSettingwithEmail:(NSString *)email
                    password:(NSString *)password
                 oldpassword:(NSString *)passwordOld
                     success:(void (^)(id response))sucess
                        fail:(void (^)(NSError *error, id response))fail {
    // url
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", PH_API_BASE_URL, PH_API_SAVESETTING];
    
    // param
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    
    [dictParam setObject:email forKey:@"email"];
    
    if (password.length > 0) {
        [dictParam setObject:password forKey:@"password"];
        [dictParam setObject:passwordOld forKey:@"oldpassword"];
    }
    
    // call web service
    [[ApiClientCore sharedInstance] sendToServiceByPost:strUrl
                                                 params:dictParam
                                                success:sucess
                                                   fail:fail];
}


@end
