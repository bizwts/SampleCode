//
//  Macros.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 27/06/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

///////////////////////////////////////[[FRAMES AND POSITIONS RELATED MACROS]]/////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Application Frame */
#define applicationFrame [[UIScreen mainScreen] applicationFrame]

/* Screen Height & Width */
#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenWidth  [[UIScreen mainScreen] bounds].size.width

/* Application Screen Height & Width */
#define applicationScreenHeight applicationFrame.size.height
#define applicationScreenWidth applicationFrame.size.width

/* Returns With CGRect instance type with values including origin and size */
// @params : a -> x Position
//          b -> y Position
//          c -> width
//          d -> height
#define Rect(a,b,c,d) CGRectMake(a, b, c, d)

/* Returns with X & Y position for any object */
#define X(v) (v).frame.origin.x
#define Y(v) (v).frame.origin.y

/* Returns with Width and Height of any object or view */
#define WIDTH(v) CGRectGetWidth((v).frame)
#define HEIGHT(v) CGRectGetHeight((v).frame)

/* Returns with Left X & Top Y Position of any object or view */
#define MinX(v) CGRectGetMinX((v).frame)
#define MinY(v) CGRectGetMinY((v).frame)

/* Returns with Center X & Center Y Position of any object or view */
#define MidX(v) CGRectGetMidX((v).frame)
#define MidY(v) CGRectGetMidY((v).frame)

/* Returns with Right X & Bottom Y Position of any object or view */
#define MaxX(v) CGRectGetMaxX((v).frame)
#define MaxY(v) CGRectGetMaxY((v).frame)



///////////////////////////////////////[[FILE MANAGER RELATED MACROS]]/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* File Manager and Document Directory access macros */
// File manager
//
#define mFileManager [NSFileManager defaultManager]

// Gets Document Directory URL
//
#define documentDirUrl [mFileManager URLForDirectory:NSDocumentDirectory inDomain:NSAllDomainsMask appropriateForURL:nil create:YES error:nil]

// Gets Document Directory Path
//
#define documentPaths NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

// Gets Document Directory
//
#define documentDir [documentPaths objectAtIndex:0]

// Returns with database path as defined in parameter
// @param database : database name that you want to create.
#define databasePath(database) [documentDir stringByAppendingPathComponent:database]

// Returns with bundle path for specified file given in parameter
// @param file : filename that you want to search in bundle
#define bundlePath(file) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:file]



///////////////////////////////////////[[USER DEFAULT RELATED MACROS]]/////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* User Defaults Macros */
// Standard User Defaults
#define UserDefault [NSUserDefaults standardUserDefaults]

// User Default Object {Get Set}
// @params object, key
#define UserDefaultObject(object) [UserDefault objectForKey:object]
#define setUserDefaultObject(object,key) { [UserDefault setObject:object forKey:key]; [UserDefault synchronize]; }

// User Default Value {Get Set}
#define UserDefaultValue(value) [UserDefault valueForKey:value]
#define setUserDefaultValue(value,key) { [UserDefault setValue:value forKey:key]; [UserDefault synchronize]; }

// User Default All Keys
#define UserDefaultKeys [[UserDefault dictionaryRepresentation] allKeys]


///////////////////////////////////////[[COMPLEX MATH FUNCTIONS RELATED MACROS]]///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)


///////////////////////////////////////[[DEVICE RELATED MACROS]]///////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Returns true if Current device is Retina, otherwise false.
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// Returns true if device is iPhone5, otherwise false.
#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// Returns true if current device is iPad, otherwise false.
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// Returns true if OS installed in current device is iOS7, otherwise false.
#define isIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

// Checks and Returns true if system version less than the applied version detail, otherwise false.
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#if !defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
# define LINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
# define TextAlignmentLeft UITextAlignmentLeft
# define TextAlignmentCenter UITextAlignmentCenter
# define TextAlignmentRight UITextAlignmentRight

#else
# define LINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
# define TextAlignmentLeft NSTextAlignmentLeft
# define TextAlignmentCenter NSTextAlignmentCenter
# define TextAlignmentRight NSTextAlignmentRight

#endif


///////////////////////////////////////[[USEFUL MACROS]]///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Returns image object from imagename string

#define DATE_COMPONENTS (NSEraCalendarUnit | NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define D_MINUTE	60


#define color(r,g,b,a) [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha:a]

#define OSVER [Util OSVersion]

#define UIImageFromNSString(string) [UIImage imageNamed:string]
#define sizeWithFont(string,font) ((OSVER < 7) ? [string sizeWithFont:font] : [string sizeWithAttributes:@{NSFontAttributeName:font}])

#define kIsIphone5Size (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 568) < DBL_EPSILON)
#define radians(degrees) (degrees * M_PI / 180)
#define degrees(radians) (radians * 180 / M_PI)
#define valForScreen(iphone4, iphone5) (kIsIphone5Size ? iphone5 : iphone4)

///////////////////////////////////////[[USE APPLICATION SPECIFIC MACROS]]/////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Statusbar Height
#define kStatusBarHeight (20.f)
// Topbar Height
#define kTopBarHeight (44.f)
// Bottombar Height
#define kBottomBarHeight (49.f)
// Default Cell Height
#define kCellDefaultHeight (44.f)

// Keyboard Heights;
#define kEnglishKeyboardHeight (216.f)
#define kChineseKeyboardHeight (252.f)

#endif