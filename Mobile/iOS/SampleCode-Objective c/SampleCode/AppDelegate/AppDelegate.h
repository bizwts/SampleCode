//
//  AppDelegate.h
//  SignMe
//
//  Created by WTS on 02/02/16.
//  Copyright © 2016 wings. All rights reserved.
//HOLIBUS120
//HOLIBUS150

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "SMAListOfActorViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    MBProgressHUD *HUD;
    Reachability *internetReachable;
    NSMutableArray *arrImages;
}
- (void)displayLoginView;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SMAListOfActorViewController *home;
@property (strong, nonatomic) UINavigationController *naviController;
@property (nonatomic, retain) NSMutableArray *imageUploadArray;
@property NSInteger currentVCNo;
@property BOOL reloadMatchData;
//@property (nonatomic, strong) RevealController *realView;
@property (nonatomic,retain)NSString *strGender,*strPassword,*strFirstName,*strMiddleName,*strLastName,*strPass,*strEmail,*strRace,*strBirthdate,*strUnionStatus,*strHeightFeet,*strheightInch,*strWeight,*strHairColor,*strHairLength,*strEyeColor,*strBodyType,*strCupSize,*strBustSize,*strFacialHair,*strBosyHair,*strShirtSize,*strCoatSize,*strChestSizeFemale,*strChestSizeFemaleTo,*strWaist,*strWaistTo,*strInSteam,*strTattoos,*strTattoosVisible,*strPiercing,*strPiercingVisible,*strGloveSize,*strGlasses,*strHatSizem,*strShoeSize,*strDisability,*strDisabilityDevice,*strCredits,*strSkills,*strUnique,*strTraining,*strimseeking,*strWorkType,*strCurrentlySigned,*strPresentationReady,*strUserid,*strAgeFrom,*strAgeTo,*strResumeDescription,*strUserImage,*strBaseServerPath,*strAgencyFromFeet,*strAgencyFromInch,*strAgencyToFeet,*strAgencyToInch,*strAgencyFromlbs,*strAgencyTolbs,*strUserType, *strSubscription, *strIsSubscribed, *strPurchaseToken,*strContactNo,*strResumePath, *strTermsAccept,*strLookingBackground,*strResume,*strUserT,*strLinkReel,*strIMDBLink,*strCurrentPassport,*strCurrentPassportStartDate,*strCurrentPassportEndDate,*strNewPath,*strContactusShow,*strCity,*strState, *strNameSideMenu, *strSearchingTalent;

@property BOOL fromDocument;
@property (strong, nonatomic) NSData *strImageData, *resumeData;
@property (nonatomic, strong) NSString *strCastingDirectorTitle;
@property (nonatomic, strong) NSDictionary *dicUserAboutYou;
@property (nonatomic,assign) NSTimer *Request_timer;
@property BOOL showNarrativeTexts;
//@property (retain, nonatomic) RevealController *revealview;
@property(nonatomic,readwrite)BOOL checkStatus;
@property (nonatomic, strong) NSString *firstname;

@property (nonatomic, retain) NSMutableArray *arrImages;
+ (AppDelegate *)sharedDelegate;
-(void)ShowLoader;
-(void)stopLoader;
-(NSString*) sha512:(NSString*)input;

- (void)logout;
- (void)loginSuccess;
- (void)start_app;
@property (nonatomic, strong) UINavigationController *navHome;

-(UIImage *)resizeImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(UIImage *)CreateAResizeImage:(UIImage *)Img ThumbSize:(CGSize)ThumbSize;
-(BOOL)isPasswordValid:(NSString *)pwd;
@end

