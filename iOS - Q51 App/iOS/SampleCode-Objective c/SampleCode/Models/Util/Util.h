//
//  Util.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 01/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <UIKit/UIKit.h>

@interface Util : NSObject

@property (nonatomic, strong) User *userLogined;

+ (instancetype)sharedInstance;

+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andLineHeight:(CGFloat)lineHeight;
+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andMaxHeight:(CGFloat)maxHeight;
+ (CGSize)textSizeForText:(NSString *)txt withFont:(UIFont *)font andWidth:(CGFloat)width;

+ (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString;

+ (id)objectFromJson:(NSString *)JSONString;
+ (id)objectFromJSON:(NSDictionary *)JSONDict;
+ (NSString *)parseJsonFromObject:(id)object;

- (void)lowQuailtyWithInputURL:(NSURL*)inputURL
                     outputURL:(NSURL*)outputURL;

- (void)signout;

- (void)prepareApplicationData;

- (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL
                             atTime:(NSTimeInterval)time;

- (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize;

- (void)cleanAllDataFiles;

- (BOOL)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration;

- (BOOL)isArray:(id)object;
- (BOOL)isUserDetailsRequired;
- (void)showAlertWithSuccess:(BOOL)success andAlertMessage:(NSString *)message;
- (void)showAlertWithSuccess:(BOOL)success andAlertMessage:(NSString *)message duration:(NSInteger)duration;

@end
