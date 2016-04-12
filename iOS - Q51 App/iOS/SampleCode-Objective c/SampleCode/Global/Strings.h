//
//  Strings.h
//  GuruListen
//
//  Created by Wingstech Solutions Pvt. Ltd. on 04/11/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

// Returns Image object from Image Name
#import <UIKit/UIKit.h>

static inline UIImage * NSStringToUIImage(NSString *imageName) { return [UIImage imageNamed:imageName]; }

static BOOL keepMeSignedIn = NO;

static NSString *regulareFont = @"HelveticaNeue";


static NSString *serverErrorMessage = @"The server is taking too long to response OR something is wrong with your internet connection. Please try again later.";

static NSString *kRememberKey = @"RememberMe";

static NSString *cameraTxt = @"Camera";
static NSString *albumTxt = @"Photo Album";
static NSString *cancelTxt = @"Cancel";

static NSString *kLastSyncedDate = @"LastSyncedDate";

static NSTimeInterval const kAFViewShakerDefaultDuration = 0.5;
static NSString * const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";

static NSString *const kUpdateAvatarNotification = @"kUpdateAvatarNotification";

static NSString *kShareCommentClickedNotification = @"ShareCommentRaisedNotification";
static NSString *kPostCommentNotification = @"PostCommentNotification";

static inline int ScreenHeight(){ return [UIScreen mainScreen].bounds.size.height; }
static inline int ScreenWidth(){ return [UIScreen mainScreen].bounds.size.width; }

static NSString *EighteenPlusTerms = @"Our Platform is available to all individuals who are at least 18 years of age. Our Platform is not available to any temporarily or indefinitely suspended users. By registering to use our Platform, you represent and warrant that you are at least 18 years of age.\n\nWe have the right, in our sole discretion, to suspend or terminate your use of our Platform and refuse any and all current or future use of all or any portion of our Platform.\n\nBy clicking I Agree button below you are agreed that you are 18+ years older.";

static NSString *SocialShareURL = @"http://www.wingstechsolutions.com";
static NSString *SocialCommentPostText = @"Comment";

static NSString *empty = @"";

// Webservice Response Objects
// Card
static NSString *kCardId = @"c_id";
static NSString *kCardAddress = @"c_address";
static NSString *kCardBackgroundImage = @"c_backgroundimage";
static NSString *kCardDesignation = @"c_designation";
static NSString *kCardDisplayname = @"c_displayname";
static NSString *kCardEmailId = @"c_emailid";
static NSString *kCardFaxnumber = @"c_faxnumber";
static NSString *kCardFullImage = @"c_fullcardimage";
static NSString *kCardIcon = @"c_icon";
static NSString *kCardLayout = @"c_layout";
static NSString *kCardMobilenumber = @"c_mobilenumber";
static NSString *kCardPinCode = @"c_pincode";
static NSString *kCardReceived = @"c_received";
static NSString *kCardStatus = @"c_status";
static NSString *kCardWebsite = @"c_website";
static NSString *kCardWorknumber = @"c_worknumber";
static NSString *kCardUserId = @"u_id";
static NSString *kCardCompanyName = @"c_companyname";
static NSString *kCardCompanyMessage = @"c_companymessage";
static NSString *kCardCity = @"c_city";
static NSString *kCardState = @"c_state";
static NSString *kCardAddressOne = @"c_address_line_one";
static NSString *kCardAddressTwo = @"c_address_line_two";
static NSString *kCardVisibility = @"c_visibility";
static NSString *kCardprofilePicture = @"u_profilepicture";
static NSString *kCardSource = @"c_cardsource";

//BannerAdBoBL
static NSString *kBannerAdca_description = @"ca_description";
static NSString *kBannerAdca_gps_location = @"ca_gps_location";
static NSString *kBannerAdca_id = @"ca_id";
static NSString *kBannerAdca_image = @"ca_image";
static NSString *kBannerAdca_link = @"ca_link";
static NSString *kBannerAdca_linkredirect = @"ca_linkredirect";
static NSString *kBannerAdca_status = @"ca_status";
static NSString *kBannerAddistance = @"distance";
static NSString *kBannerAdu_id = @"u_id";

// User
static NSString *kUserId = @"user_id";
static NSString *kUserName = @"user_name";
static NSString *kUserFullName = @"name";
static NSString *kUserEmail = @"email_address";
static NSString *kUserFirstName = @"first_name";
static NSString *kUserLastName = @"last_name";
static NSString *kUserGender = @"gender";
static NSString *kUserContactNumber = @"phone_number";
static NSString *kUserBirthdate = @"dob";
static NSString *kUserAddress = @"address";
static NSString *kUserCurrentCity = @"city";
static NSString *kUserCurrentState = @"state";
static NSString *kUserCurrentCountry = @"country";
static NSString *kUserProfileImage = @"profile_image";
static NSString *kUserSocialType = @"social_type";
static NSString *kUserExternalId = @"external_id";
static NSString *kUserCreatedDate = @"created_date";
static NSString *kUserLastModifiedDate = @"last_modified_date";
static NSString *kUserChatEnable = @"enable_chat";

#pragma mark - Cached Photo Attributes
// keys
static NSString *const kGLCommentAttributesIsLikedByCurrentUserKey = @"isLikedByCurrentUser";
static NSString *const kGLCommentAttributesIsDislikedByCurrentUserKey = @"isDislikedByCurrentUser";
static NSString *const kGLCommentAttributesIsStarredByCurrentUserKey = @"isStarredByCurrentUser";

static NSString *const strConstV = @"abcd";

static NSString *const kGLCommentAttributesLikeCountKey            = @"likeCount";
//static NSString *const kGLCommentAttributesLikersKey               = @"likers";
static NSString *const kGLCommentAttributesCommentCountKey         = @"commentCount";
//static NSString *const kGLCommentAttributesCommentersKey           = @"commenters";

#pragma mark - NotificationKey

static NSString *const kNotificationReceiveCard = @"ReceiveCard";
static NSString *const kNotificationNewCardAdded = @"NewCardAdded";
static NSString *const kNotificationBoBLAdAdded = @"BoBLAddAdded";
static NSString *const kNotificationiAdFullScreen = @"ShowFullScreeniAD";
static NSString *const kNotificationUpdateAvatar = @"UserAvatar";
static NSString *const kNotificationAppStatus = @"SideMenuAppStatus";
static NSString *const kNotificationHideiAd = @"HideAppleAd";
static NSString *const kNotificationUpdateUserAavtar = @"UpdateUserAvatar";

#pragma mark - Cached User Attributes
// keys
static NSString *const kGLUserAttributesCommentCountKey                 = @"commentCount";
static NSString *const kGLUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";

static NSString *const kGLUserDefaultsCacheFacebookFriendsKey                     = @"com.wingstech.GuruListen.userDefaults.cache.facebookFriends";

static NSString *const GLCommentDetailsViewControllerUserLikedUnlikedCommentNotification  = @"com.wingstech.GuruListen.commentDetailsViewController.userLikedUnlikedCommentInDetailsViewNotification";
static NSString *const GLCommentDetailsViewControllerUserCommentedOnCommentPostNotification   = @"com.wingstech.GuruListen.commentDetailsViewController.userCommentedOnCommentInDetailsViewNotification";

//UIAlertView Tag No
static NSInteger alrtResumeTag = 1;
