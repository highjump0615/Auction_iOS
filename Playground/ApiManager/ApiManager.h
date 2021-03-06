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
+ (NSString *)getErrorDescription:(NSError *)error response:(id)response;

- (void)setApiToken:(NSString *)value;
- (void)loadApiToken;

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

- (void)getUserWithId:(NSInteger)userId
              success:(void (^)(id response))sucess
                 fail:(void (^)(NSError *error, id response))fail;

- (void)getUserInfo:(void (^)(id response))sucess
               fail:(void (^)(NSError *error, id response))fail;

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
                       fail:(void (^)(NSError *error, id response))fail;

- (void)getExplore:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail;

- (void)getCategoryItem:(NSInteger)category
                success:(void (^)(id response))sucess
                   fail:(void (^)(NSError *error, id response))fail;

- (void)searchItem:(NSString *)keyword
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail;

- (void)placeBidWithPrice:(NSInteger)price
                     item:(NSInteger)itemId
                  success:(void (^)(id response))sucess
                     fail:(void (^)(NSError *error, id response))fail;

//- (void)getMaxBidOnItem:(NSInteger)itemId
//                success:(void (^)(id response))sucess
//                   fail:(void (^)(NSError *error, id response))fail;

- (void)getComment:(NSInteger)itemId
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail;

- (void)addComment:(NSString *)comment
            parent:(NSInteger)parentId
              item:(NSInteger)itemId
           success:(void (^)(id response))sucess
              fail:(void (^)(NSError *error, id response))fail;

- (void)saveProfilewithUsername:(NSString *)username
                           name:(NSString *)name
                       birthday:(NSString *)birthday
                         gender:(NSInteger)gender
                          photo:(NSData *)photo
                        success:(void (^)(id response))sucess
                           fail:(void (^)(NSError *error, id response))fail;

- (void)saveSettingwithEmail:(NSString *)email
                    password:(NSString *)password
                 oldpassword:(NSString *)passwordOld
                     success:(void (^)(id response))sucess
                        fail:(void (^)(NSError *error, id response))fail;

- (void)contactItemWithId:(NSInteger)itemId
                  success:(void (^)(id response))sucess
                     fail:(void (^)(NSError *error, id response))fail;

- (void)giveupBidWithItemId:(NSInteger)itemId
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail;

- (void)deleteBidWithItemId:(NSInteger)itemId
                    success:(void (^)(id response))sucess
                       fail:(void (^)(NSError *error, id response))fail;

- (void)getInbox:(void (^)(id response))sucess
            fail:(void (^)(NSError *error, id response))fail;

- (void)deleteInboxWithId:(NSInteger)inboxId
                  success:(void (^)(id response))sucess
                     fail:(void (^)(NSError *error, id response))fail;

- (void)rateItemWithId:(NSInteger)itemId
                  rate:(NSInteger)value
               success:(void (^)(id response))sucess
                  fail:(void (^)(NSError *error, id response))fail;

@end
