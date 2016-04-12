//
//  Util.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 01/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Util.h"
#import "TWMessageBarManager.h"
#import "Strings.h"
#import "NSString+KMKit.h"
#import "Constants.h"

@implementation Util {
    User *currentUser_;
}

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Shake Animation

- (BOOL)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    
    if (view == nil) return NO;
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
    
    return YES;
}

-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode  {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle
                                  };
    
    
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andLineHeight:(CGFloat)lineHeight
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    CGFloat maxHeight = [txt numberOfLines] * lineHeight;
    
    CGSize stringSize;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        CGRect stringRect = [txt boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : font }
                                              context:nil];
        
        stringSize = CGRectIntegral(stringRect).size;
    }
    else {
//        stringSize = [txt sizeWithFont:font
//                     constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
        stringSize = [[Util sharedInstance] frameForText:txt sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, maxHeight) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return CGSizeMake(roundf(stringSize.width), roundf(stringSize.height));
}

+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andMaxHeight:(CGFloat)maxHeight
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    
    CGSize stringSize;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        CGRect stringRect = [txt boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : font }
                                              context:nil];
        
        stringSize = CGRectIntegral(stringRect).size;
    }
    else {
        //        stringSize = [txt sizeWithFont:font
        //                     constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
        stringSize = [[Util sharedInstance] frameForText:txt sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, maxHeight) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return CGSizeMake(roundf(stringSize.width), roundf(stringSize.height));
}

+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andWidth:(CGFloat)width
{
    CGFloat maxWidth = width;
    CGFloat maxHeight = 9999;
    
    CGSize stringSize;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
        CGRect stringRect = [txt boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : font }
                                              context:nil];
        
        stringSize = CGRectIntegral(stringRect).size;
    }
    else {
//        stringSize = [txt sizeWithFont:font
//                     constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
        stringSize = [[Util sharedInstance] frameForText:txt sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, maxHeight) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return CGSizeMake(roundf(stringSize.width), roundf(stringSize.height + 20));
}

+ (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}

+ (id)objectFromJson:(NSString *)JSONString
{
    NSData * jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error=nil;
    id parsed = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if([parsed isKindOfClass:[NSDictionary class]] || [parsed isKindOfClass:[NSArray class]])
        return parsed;
    else
        return nil;
}

+ (id)objectFromJSON:(NSDictionary *)JSONDict {
    NSError * error=nil;
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:JSONDict
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    id parsed = [NSJSONSerialization JSONObjectWithData:dataFromDict options:kNilOptions error:&error];
    if([parsed isKindOfClass:[NSDictionary class]] || [parsed isKindOfClass:[NSArray class]])
        return parsed;
    else
        return nil;
}

+ (NSString *)parseJsonFromObject:(id)object
{
    @try {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:0
                                                             error:&error];
        
        if (!jsonData) {
            return nil;
        } else {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (BOOL)isArray:(id)object {
    return [object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSMutableArray class]];
}

- (void)signout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"CurrentLoginUser"];
    [defaults synchronize];
    
    currentUser_ = nil;
}

//- (BOOL)isUserDetailsRequired {
//    return ([currentUser_.address length] == 0 || [currentUser_.phone_no length] == 0);
//}

//- (void)setUserLogined:(User *)userLogined
//{
//    currentUser_ = userLogined;
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:[userLogined userDictionaryFromUser:userLogined] forKey:@"CurrentLoginUser"];
//    [defaults synchronize];
//}

- (User *)userLogined   {
    if (!currentUser_) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"CurrentLoginUser"]) {
            return nil;
        }
        
        //currentUser_ = [[User alloc] initWithDic:[defaults objectForKey:@"CurrentLoginUser"]];
    }
    return currentUser_;
}

- (void)prepareApplicationData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *audioDirectory = [documentsDirectory stringByAppendingPathComponent:@"Audio"];
        NSString *coverDirectory = [documentsDirectory stringByAppendingPathComponent:@"Cover"];
        NSString *videoDirectory = [documentsDirectory stringByAppendingPathComponent:@"Video"];
        
        BOOL isDir = YES;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:audioDirectory isDirectory:&isDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:audioDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:coverDirectory isDirectory:&isDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:coverDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:videoDirectory isDirectory:&isDir]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:videoDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:APP_DATABASE];
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentLibraryFolderPath]) {
            NSString *resourceFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:APP_DATABASE];
            NSData *mainBundleFile = [NSData dataWithContentsOfFile:resourceFolderPath];
            [[NSFileManager defaultManager] createFileAtPath:documentLibraryFolderPath
                                                    contents:mainBundleFile
                                                  attributes:nil];
        }
    });
}

- (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL
                             atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetIG = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetIG.appliesPreferredTrackTransform = YES;
    assetIG.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *igError = nil;
    thumbnailImageRef = [assetIG copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)
                                        actualTime:NULL
                                             error:&igError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", igError );
    
    UIImage *thumbnailImage = thumbnailImageRef
    ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]
    : nil;
    
    return thumbnailImage;
}

- (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= newSize.width && height <= newSize.height){
        return image;
    }
    
    if (width == 0 || height == 0){
        return image;
    }
    
    CGFloat widthFactor = newSize.width / width;
    CGFloat heightFactor = newSize.height / height;
    CGFloat scaleFactor = (widthFactor<heightFactor?widthFactor:heightFactor);
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth,scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize);
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)lowQuailtyWithInputURL:(NSURL*)inputURL
                     outputURL:(NSURL*)outputURL
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    session.outputURL = outputURL;
    session.outputFileType = AVFileTypeQuickTimeMovie;
    [session exportAsynchronouslyWithCompletionHandler:^(void) {
        
    }];
}

- (void)cleanAllDataFiles
{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//        NSArray *storyIdentities = [[StoryService new] storyList];
//        NSArray *dirList = @[[documentsDirectory stringByAppendingPathComponent:@"Cover"],
//                             [documentsDirectory stringByAppendingPathComponent:@"Audio"],
//                             [documentsDirectory stringByAppendingPathComponent:@"Video"]];
//        for (NSString *dirPath in dirList) {
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            NSURL *diskCacheURL = [NSURL fileURLWithPath:dirPath isDirectory:YES];
//            NSArray *resourceKeys = @[NSURLIsDirectoryKey, NSURLNameKey];
//            NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtURL:diskCacheURL
//                                                      includingPropertiesForKeys:resourceKeys
//                                                                         options:NSDirectoryEnumerationSkipsHiddenFiles
//                                                                    errorHandler:NULL];
//            for (NSURL *fileURL in fileEnumerator) {
//                NSDictionary *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
//                if ([resourceValues[NSURLIsDirectoryKey] boolValue])
//                {
//                    continue;
//                }
//                NSString *fileIdentity = [[resourceValues[NSURLNameKey] componentsSeparatedByString:@"."] objectAtIndex:0];
//                
//                BOOL fileWithStory = NO;
//                for (NSString *identity in storyIdentities) {
//                    if ([identity isEqualToString:fileIdentity]) {
//                        fileWithStory = YES;
//                        break;
//                    }
//                }
//                
//                if (!fileWithStory) {
//                    [fileManager removeItemAtURL:fileURL error:nil];
//                }
//            }
//        }
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD showSuccessWithStatus:@"Done"];
//        });
//    });
}

- (void)showAlertWithSuccess:(BOOL)success andAlertMessage:(NSString *)message {
    NSLog(@"111");
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:APP_NAME
                                                   description:message
                                                          type:success?TWMessageBarMessageTypeSuccess:TWMessageBarMessageTypeError
                                                      duration:5.0];
}

- (void)showAlertWithSuccess:(BOOL)success andAlertMessage:(NSString *)message duration:(NSInteger)duration{
    NSLog(@"222");
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:APP_NAME
                                                   description:message
                                                          type:success?TWMessageBarMessageTypeSuccess:TWMessageBarMessageTypeError
                                                      duration:duration];
}

@end
