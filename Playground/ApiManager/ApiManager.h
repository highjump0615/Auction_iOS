//
//  ApiManager.h
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject {
    NSString *_apiToken;
}

@property (nonatomic, retain) NSString *apiToken;

+ (ApiManager *)sharedInstance;
+ (NSInteger)getStatusCode:(NSError *)error;

- (void)setApiToken:(NSString *)value;

- (void)userSigninwithUsername:(NSString *)username
                      password:(NSString *)password
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail;

- (void)userSignupwithUsername:(NSString *)username
                      password:(NSString *)password
                          name:(NSString *)name
                         email:(NSString *)email
                      birthday:(NSString *)birthday
                        gender:(NSInteger)gender
                         photo:(NSData *)photo
                       success:(void (^)(id response))sucess
                          fail:(void (^)(NSError *error, id response))fail;

- (void)getUser:(void (^)(id response))sucess
           fail:(void (^)(NSError *error, id response))fail;


@end
