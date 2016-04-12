//
//  Social.h
//  GuruListen
//
//  Created by Wingstech Solutions Pvt. Ltd. on 04/11/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#ifndef Social_h
#define Social_h

// FACEBOOK APP ID AND APP SECRET
#define g_kFacebookAppId        @"<Your AppID>"
#define g_kFacebookAppSecret    @"<Your Secret>"

// FACEBOOK ACCESS TOKEN AND EXPIRATION DATE
#define g_kFacebookAccessToken      @"FBAccessTokenKey"
#define g_kFacebookExpirationDate   @"FBExpirationDateKey"

// FACEBOOK POST MACROS
#define g_kPostMessage          @"<Message>"
#define g_kPostUrlTitle         @"<Title>"
#define g_kPostUrl              @"<Url>"
#define g_kPostCaption          @"<Caption>"
#define g_kPostPictureUrl       @"<Image Url>"

//AppID Missing
#define msgFBAppIDMissing @"Missing AppID"

//Session Invalidated
#define msgFBSessionInvalidateTitle @"Auth Exception"
#define msgFBSessionInvalidateMessage @"Your session has expired."


// TWITTER APP ID AND APP SECRET
#define SOCIAL_TWITTER_KEY @"<Your Twitter Key>"
#define SOCIAL_TWITTER_SECRET @"<Your Twitter Secret Key>"

#define NOTIFICATION_TWITTER_LOGIN_SUCCED @"TwitterLoginSuccess"
#define NOTIFICATION_TWITTER_LOGIN_FAILED @"TwitterLoginFailed"

#endif