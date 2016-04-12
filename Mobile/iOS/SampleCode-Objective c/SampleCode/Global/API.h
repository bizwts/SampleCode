//
//  API.h
//  GuruListen
//
//  Created by Wingstech Solutions Pvt. Ltd. on 04/11/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//2 = premium
//1 = cloud
//0 = ad

#ifndef API_h
#define API_h

#pragma mark Local Server

// API RELATIVE PATH FOR PUBLIC DATA
//#define API_RELATIVE_PATH_PUBLIC [NSString stringWithFormat:@"%@/bobl_app/api/public/", HOST_NAME]
//#define BASEPATH @"http://192.168.1.99/signmeapp/"
#define BASEPATH @"http://www.globaltechnologys.com/ws/"

#pragma BoBL Server
#define HOST_NAME @""
#define HOST_ImageName @""

//API RELATIVE PATH FOR PUBLIC DATA
#define API_RELATIVE_PATH_PUBLIC [NSString stringWithFormat:@"%@/~bobl/bobl/api/public/", HOST_NAME]

//#define HOST_NAME @"http://wingstechsolutions.com/ts/"

#pragma mark Chip Server
//#define HOST_NAME @"http://chicagohospitalityandindustryperks.com"
//#define HOST_ImageName @"http://chicagohospitalityandindustryperks.com/bobl"


//Chip server
//#define API_RELATIVE_PATH_PUBLIC [NSString stringWithFormat:@"%@/bobl/api/public/", HOST_NAME]
// API RELATIVE PATH FOR STATIC DATA
//bobl_app
#define API_RELATIVE_PATH_STATIC [NSString stringWithFormat:@"%@/bobl_app/api/static", HOST_NAME]

//Chip server
//#define API_RELATIVE_PATH_STATIC [NSString stringWithFormat:@"%@/bobl/api/static", HOST_NAME]

// MAIN API PATH
#define API_PATH(path) [NSString stringWithFormat:@"%@%@", API_RELATIVE_PATH_PUBLIC, path]

// API STATIC PATH
#define STATIC_API_PATH(path) [NSString stringWithFormat:@"%@/%@",API_RELATIVE_PATH_STATIC, path]

// LOGIN API
#define API_USERS_SIGNIN API_PATH(@"user/signin")

// REGISTER API
#define API_USERS_SIGNUP API_PATH(@"user/signup")



// Update user data API
#define API_USERS_EDIT_DATA API_PATH(@"users/profile")

// USER LIST
#define API_USERS        API_PATH(@"/users")

// UPLOAD USER PROFILE PICTURE
#define API_USERS_UPLOAD_AVATAR API_PATH(@"users/profileimage/%d")

// UPDATE USER
#define API_USERS_UPDATE API_PATH(@"/users/%d")

//Update card logo icon
#define API_UPDATE_CADRD_LOGO API_PATH(@"cards/uploadlogo/logo")

// New CARD DETAIL
#define API_EDIT_CARD_DETAIL API_PATH(@"cards/savecardimei")
//api/public/cards/savecardimei
//cards/savecard

// Update CARD DETAIL
#define API_UPDATE_CARD_DETAIL API_PATH(@"cards/updatecard")

//UPDATE CARD DETAIL IMAGE
#define API_EDIT_CARD_DETAIL_IMAGE API_PATH(@"cards/uploadcard/image")

//Get Own Card in home screen
#define API_FETCH_MY_CARDS API_PATH(@"cards/getmycards")

//Reset GetDetail cloud storage.
#define API_GET_CLOUD_STORAGE API_PATH(@"purchase/getremainingreceivedcloudstorage/%d")

#endif