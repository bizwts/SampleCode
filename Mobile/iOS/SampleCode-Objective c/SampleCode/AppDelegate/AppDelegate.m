//
//  AppDelegate.m
//  SignMe
//
//  Created by WTS on 02/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "AppDelegate.h"
#import "Themes.h"
#import "SMALoginViewController.h"
#import "SMASideMenuViewController.h"

#import "MMDrawerController.h"
#import "Macros.h"
#import "serverAPIClass.h"
#import "Constants.h"
#import "SMAViewActorProfileViewController.h"
#include <CommonCrypto/CommonDigest.h>
#import "SMAListOfActorViewController.h"
#import "SMAViewActorProfileViewController.h"
#import "SMAIntroductionVC.h"
#import "AFNetworking.h"
#import "SMASplashVC.h"
@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navControl;
@property (nonatomic, strong) SMALoginViewController *login;

@property (nonatomic, strong) UINavigationController *navSplash;
@property (nonatomic, strong) SMASplashVC *spalsh;
@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) SMAIntroductionVC *introcution;
@property (nonatomic, strong) UINavigationController *navIntroduction;

@property (nonatomic, strong) SMASideMenuViewController *sideMenu;
@property (nonatomic, strong) UINavigationController *navSideMenu;
@property (nonatomic, strong) SMAViewActorProfileViewController *viewActorProfile;

@end

@implementation AppDelegate
@synthesize strGender,strPassword,strFirstName,strMiddleName,strLastName,strPass,strEmail,strRace,strBirthdate,strUnionStatus,strHeightFeet,strheightInch,strWeight,strHairColor,strHairLength,strEyeColor,strBodyType,strCupSize,strBustSize,strFacialHair,strBosyHair,strShirtSize,strCoatSize,strChestSizeFemale,strChestSizeFemaleTo,strWaist,strWaistTo,strInSteam,strTattoos,strTattoosVisible,strPiercing,strPiercingVisible,strGloveSize,strGlasses,strHatSizem,strShoeSize,strDisability,strDisabilityDevice,strCredits,strSkills,strUnique,strTraining,strimseeking,strWorkType,strCurrentlySigned,strPresentationReady,strImageData,Request_timer,strUserid,strAgeFrom,strAgeTo,strResumeDescription,checkStatus,strUserImage,strBaseServerPath,strAgencyFromFeet,strAgencyFromInch,strAgencyToFeet,strAgencyToInch,strAgencyFromlbs,strAgencyTolbs,strUserType, strSubscription, strIsSubscribed, strPurchaseToken, arrImages,imageUploadArray,strContactNo, resumeData, strResumePath, strTermsAccept,strLookingBackground,strResume,strUserT,strLinkReel,strIMDBLink,strCurrentPassport,strCurrentPassportStartDate,strCurrentPassportEndDate,strNewPath,strContactusShow,strCity,strState, strSearchingTalent;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    _currentVCNo = 0;
    strBaseServerPath = ServerApi.base_path;
    
    NSDictionary *dic = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"RememberMe"];
    NSLog(@"dic = %@",dic);
    
     self.window.rootViewController = [self navSplash];
    
    return YES;
}

- (void)logout {
    checkStatus =false;
    [AppDelegate sharedDelegate].strCastingDirectorTitle = @"";
    //clear data start
    [AppDelegate sharedDelegate].strFirstName=@"";
    [AppDelegate sharedDelegate].strMiddleName=@"";
    [AppDelegate sharedDelegate].strLastName=@"";
    [AppDelegate sharedDelegate].strEmail=@"";
    [AppDelegate sharedDelegate].strGender=@"";
    [AppDelegate sharedDelegate].strRace=@"";
    [AppDelegate sharedDelegate].strBirthdate=@"";
    [AppDelegate sharedDelegate].strAgeFrom=@"";
    [AppDelegate sharedDelegate].strAgeTo=@"";
    [AppDelegate sharedDelegate].strUnionStatus=@"";
    [AppDelegate sharedDelegate].strHeightFeet=@"";
    [AppDelegate sharedDelegate].strheightInch=@"";
    [AppDelegate sharedDelegate].strWeight=@"";
    [AppDelegate sharedDelegate].strHairColor=@"";
    [AppDelegate sharedDelegate].strHairLength=@"";
    [AppDelegate sharedDelegate].strEyeColor=@"";
    [AppDelegate sharedDelegate].strBodyType=@"";
    [AppDelegate sharedDelegate].strCupSize=@"";
    [AppDelegate sharedDelegate].strBustSize=@"";
    [AppDelegate sharedDelegate].strFacialHair=@"";
    [AppDelegate sharedDelegate].strBosyHair=@"";
    [AppDelegate sharedDelegate].strTattoosVisible=@"";
    [AppDelegate sharedDelegate].strPiercingVisible=@"";
    [AppDelegate sharedDelegate].strPiercing = @"";
    [AppDelegate sharedDelegate].strTattoos = @"";
    [AppDelegate sharedDelegate].strHatSizem=@"";
    [AppDelegate sharedDelegate].strGloveSize=@"";
    [AppDelegate sharedDelegate].strShoeSize=@"";
    [AppDelegate sharedDelegate].strWaist=@"";
    [AppDelegate sharedDelegate].strWaistTo=@"";
    [AppDelegate sharedDelegate].strShirtSize=@"";
    [AppDelegate sharedDelegate].strCoatSize=@"";
    [AppDelegate sharedDelegate].strChestSizeFemale=@"";
    [AppDelegate sharedDelegate].strInSteam=@"";
    [AppDelegate sharedDelegate].strGlasses=@"";
    [AppDelegate sharedDelegate].strDisability=@"";
    [AppDelegate sharedDelegate].strDisabilityDevice=@"";
    [AppDelegate sharedDelegate].strCredits=@"";
    [AppDelegate sharedDelegate].strSkills=@"";
    [AppDelegate sharedDelegate].strUnique=@"";
    [AppDelegate sharedDelegate].strTraining=@"";
    [AppDelegate sharedDelegate].strimseeking=@"";
    [AppDelegate sharedDelegate].strWorkType=@"";
    [AppDelegate sharedDelegate].strCurrentlySigned=@"";
    [AppDelegate sharedDelegate].strPresentationReady=@"";
    [AppDelegate sharedDelegate].strResumeDescription=@"";
    [AppDelegate sharedDelegate].strSubscription=@"";
    [AppDelegate sharedDelegate].strPurchaseToken=@"";
    strUserid = @"";
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"type"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userid"];
    
    _navIntroduction = nil;
    _introcution = nil;
    
    _navSideMenu = nil;
    _sideMenu = nil;
    _viewActorProfile = nil;
    
    _navControl = nil;
    _login = nil;
    
    _naviController = nil;
    _home = nil;
    
    _drawerController = nil;
    
    
    _navHome = nil;
    
    [self start_app];
}

- (void)start_app {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSLog(@"userId = %@",userId);
    
    if (userId.length > 0) {
            NSLog(@"Preference available");
            NSString *strType = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
            if ([strType isEqualToString:@"1"]) {
                strUserid = userId;
                strSubscription = @"";
                strIsSubscribed = @"";
                
                strUserType = @"1";
                checkStatus = YES;
                
                [self loginSuccess];
            }
            else if ([strType isEqualToString:@"2"]) {
                strUserid = userId;
                
                strUserType = @"2";
                checkStatus = YES;
                [self loginSuccess];

            }
            else {
                strUserid = userId;
                strUserType = @"0";
                checkStatus = YES;
                [self loginSuccess];

            }
        }else               {
            self.window.rootViewController = [self navControl];
            //self.window.rootViewController = [self navSplash];
        }
        //NSString *strType = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
        strUserid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
}

- (void)navigationSetUP {
    [UINavigationBar appearance].barTintColor = NavigationColor;
    [UINavigationBar appearance].tintColor = BaseColor;
    //[UINavigationBar appearance].titleTextAttributes = [NSForegroundColorAttributeName : BaseColor];
}

- (SMAIntroductionVC *)introcution {
    if (!_introcution) {
        _introcution = [[SMAIntroductionVC alloc] init];
    }
    return _introcution;
}

- (UINavigationController *)navIntroduction {
    if (!_navIntroduction) {
        _navIntroduction = [[UINavigationController alloc] initWithRootViewController:[self introcution]];
    }
    return _navIntroduction;
}

- (SMASplashVC *)spalsh {
    if (!_spalsh) {
        _spalsh = [[SMASplashVC alloc] init];
    }
    return _spalsh;
}

- (SMALoginViewController *)login {
    if (!_login) {
        _login = [[SMALoginViewController alloc] init];
    }
    return _login;
}

- (UINavigationController *)navSplash {
    if (!_navSplash) {
        _navSplash = [[UINavigationController alloc] initWithRootViewController:[self spalsh]];
    }
    return _navSplash;
}

- (UINavigationController *)navControl {
    if (!_navControl) {
        _navControl = [[UINavigationController alloc] initWithRootViewController:[self login]];
    }
    return _navControl;
}

- (void)loginSuccess {
    _navControl = nil;
    _navIntroduction = nil;
    _navSplash = nil;
    _navSideMenu = nil;
    _naviController= nil;
    _login = nil;
    _sideMenu = nil;
    _introcution = nil;
    _spalsh = nil;
    self.window.rootViewController = [self drawerController];
}

+ (AppDelegate *)sharedDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (MMDrawerController *)drawerController {
    
    if (!_drawerController) {
        _drawerController = [[MMDrawerController alloc] initWithCenterViewController:[self navHome]
                                                            leftDrawerViewController:[self sideMenu]
                                                           rightDrawerViewController:nil];
        _drawerController.view.backgroundColor = [UIColor whiteColor];
        _drawerController.maximumLeftDrawerWidth = screenWidth - 60;
        _drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        _drawerController.openDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
        //_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
    }
    return _drawerController;
}

- (void)launchScreen {
    self.window.rootViewController = [self drawerController];
}

- (UINavigationController *)navSideMenu {
    if (!_navSideMenu) {
        _navSideMenu = [[UINavigationController alloc] initWithRootViewController:[self sideMenu]];
    }
    return _navSideMenu;
}

- (SMASideMenuViewController *)sideMenu {
    if (!_sideMenu) {
        _sideMenu = [[SMASideMenuViewController alloc] init];
    }
    return _sideMenu;
}

- (SMAViewActorProfileViewController *)viewActorProfile {
    if (!_viewActorProfile) {
        _viewActorProfile = [[SMAViewActorProfileViewController alloc] init];
        _viewActorProfile.userType = 1;
        _viewActorProfile.strUserId = strUserid;
    }
    return _viewActorProfile;
}

- (UINavigationController *)navHome {
    if (!_navHome) {
        if ([strUserType isEqualToString:@"1"]) {
            _navHome = [[UINavigationController alloc]initWithRootViewController:[self viewActorProfile]];
        }else {
            _navHome = [[UINavigationController alloc]initWithRootViewController:[self home]];
        }
    }
    return _navHome;
}

- (SMAListOfActorViewController *)home {
    if (!_home) {
        _home = [[SMAListOfActorViewController alloc]init];
    }
    return _home;
}

-(NSString*) sha512:(NSString*)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(UIImage *)resizeImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a bitmap context.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *)CreateAResizeImage:(UIImage *)Img ThumbSize:(CGSize)ThumbSize {
    float actualHeight = Img.size.height; float actualWidth = Img.size.width;
    if(actualWidth==actualHeight) { actualWidth = ThumbSize.width; actualHeight = ThumbSize.height; }
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = ThumbSize.width/ThumbSize.height;   //320.0 /480.0;
    
    
    if(imgRatio!=maxRatio) {
        if(imgRatio < maxRatio) {
            imgRatio = ThumbSize.height / actualHeight; //480.0  / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = ThumbSize.height; //480.0;
        } else {
            imgRatio = ThumbSize.width / actualWidth;   //320.0  / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = ThumbSize.width; //320.0;
        }
    } else {
        actualWidth = ThumbSize.width;
        actualHeight = ThumbSize.height;
    }
    CGRect rect = CGRectMake(0, 0, (int)actualWidth, (int)actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [Img drawInRect:rect];
    UIImage *NewImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return NewImg;
}


-(void)ShowLoader{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    HUD.color = [UIColor colorWithWhite:0.701 alpha:1.000];
    HUD.tag=9999998;
    HUD.hidden = false;
    HUD.labelText = @"";
    [HUD show:YES];
}

-(void)stopLoader{
    [[[[[UIApplication sharedApplication] delegate] window] viewWithTag:9999998]removeFromSuperview];
    [HUD removeFromSuperview];
    [HUD hide:YES];
}

#pragma mark- Check Network Status

- (void)checkNetworkStatus:(NSNotification *)notice{
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    if(internetStatus == NotReachable)    {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:nil message:@"Internet unavailable. Please try again." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN))
    {    }
}

-(BOOL)isPasswordValid:(NSString *)pwd{
    if ( [pwd length]<7)
        return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    if ([[AppDelegate sharedDelegate].strUserType isEqualToString:@"1"]) {
        rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
        if ( !rang.length )
            return NO;// no number;
    }
    return YES;
}


@end
