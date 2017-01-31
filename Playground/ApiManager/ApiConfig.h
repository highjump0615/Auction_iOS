//
//  ApiConfig.h
//  Playground
//
//  Created by Top1 on 1/26/17.
//  Copyright © 2017 fred. All rights reserved.
//

#ifndef ApiConfig_h
#define ApiConfig_h

#define     PH_FAIL_STATE               400

#define     PH_API_BASE_URL             @"http://192.168.1.100/playground/public/api/v1/"
#define     PH_API_BASE_ITEM_FILE_URL   @"http://192.168.1.100/playground/public/uploads/item/"
#define     PH_API_BASE_USER_FILE_URL   @"http://192.168.1.100/playground/public/uploads/user/"

// user api
#define     PH_API_LOGIN                @"login"
#define     PH_API_SIGNUP               @"signup"
#define     PH_API_GETUSER              @"user"
#define     PH_API_GETUSERINFO          @"userinfo"

// item api
#define     PH_API_UPLOAD_ITEM          @"uploaditem"
#define     PH_API_EXPLORE              @"explore"
#define     PH_API_GETCATEGORY          @"category"
#define     PH_API_SEARCH_ITEM          @"search"

// bid api
#define     PH_API_BID_ITEM             @"bid"
#define     PH_API_GETMAXBID            @"maxbid"

// comment api
#define     PH_API_GETCOMMENT           @"comment"
#define     PH_API_ADDCOMMENT           @"addcomment"



#endif /* ApiConfig_h */
