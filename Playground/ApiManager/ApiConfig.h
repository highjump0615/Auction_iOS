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

#define     PH_API_BASE_URL             @"http://tnb.vij.mybluehost.me/playground/public/api/v1/"
#define     PH_API_BASE_ITEM_FILE_URL   @"http://tnb.vij.mybluehost.me/playground/public/uploads/item/"
#define     PH_API_BASE_USER_FILE_URL   @"http://tnb.vij.mybluehost.me/playground/public/uploads/user/"
//#define     PH_API_BASE_URL             @"http://localhost/playground/public/api/v1/"
//#define     PH_API_BASE_ITEM_FILE_URL   @"http://localhost/playground/public/uploads/item/"
//#define     PH_API_BASE_USER_FILE_URL   @"http://localhost/playground/public/uploads/user/"


// user api
#define     PH_API_LOGIN                @"login"
#define     PH_API_SIGNUP               @"signup"
#define     PH_API_GETUSER              @"user"
#define     PH_API_GETUSERINFO          @"userinfo"
#define     PH_API_SAVEPROFILE          @"saveprofile"
#define     PH_API_SAVESETTING          @"savesetting"

// item api
#define     PH_API_UPLOAD_ITEM          @"uploaditem"
#define     PH_API_EXPLORE              @"explore"
#define     PH_API_GETCATEGORY          @"category"
#define     PH_API_SEARCH_ITEM          @"search"
#define     PH_API_CONTACT_ITEM         @"contact"

// bid api
#define     PH_API_BID_ITEM             @"bid"
#define     PH_API_GETMAXBID            @"maxbid"
#define     PH_API_GIVEUPBID            @"giveup"
#define     PH_API_DELETEBID            @"delete"

// comment api
#define     PH_API_GETCOMMENT           @"comment"
#define     PH_API_ADDCOMMENT           @"addcomment"



#endif /* ApiConfig_h */
