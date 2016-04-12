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
//#define BASEPATH @""
#define BASEPATH @""

#pragma BoBL Server
#define HOST_NAME @""
#define HOST_ImageName @""

//API RELATIVE PATH FOR PUBLIC DATA
#define API_RELATIVE_PATH_PUBLIC [NSString stringWithFormat:@"", HOST_NAME]

//#define HOST_NAME @""

#pragma mark Chip Server
//#define HOST_NAME @""
//#define HOST_ImageName @""

//bobl_app
#define API_RELATIVE_PATH_STATIC [NSString stringWithFormat:@"", HOST_NAME]

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


#endif