//
//  NSString+KMKit.h
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 10/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KMKit)

- (NSString*) MD5;
- (NSString*) SHA1;
- (NSString*) SHA256;

- (BOOL)isValidEmailWithStricterFilter:(BOOL)stricterFilter;
- (BOOL)isNilOrEmpty;

- (NSUInteger)numberOfLines;

- (NSDate *)dateFormat;
- (NSDate *)dateWithFormat:(NSString *)format;
- (NSDate *)scanDate;

- (NSString *)noSpaceString;
- (BOOL)isEmpty;

@end
