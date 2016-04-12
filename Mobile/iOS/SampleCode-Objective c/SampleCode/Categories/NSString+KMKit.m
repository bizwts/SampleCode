//
//  NSString+KMKit.m
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 10/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "NSString+KMKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KMKit)

- (NSString*)MD5
{
    unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_MD5(self.UTF8String, [self UTF8Length], output);
    return [self toHexString:output length:outputLength];;
}

- (NSString*)SHA1
{
    unsigned int outputLength = CC_SHA1_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_SHA1(self.UTF8String, [self UTF8Length], output);
    return [self toHexString:output length:outputLength];;
}

- (NSString*)SHA256
{
    unsigned int outputLength = CC_SHA256_DIGEST_LENGTH;
    unsigned char output[outputLength];
    
    CC_SHA256(self.UTF8String, [self UTF8Length], output);
    return [self toHexString:output length:outputLength];;
}

- (unsigned int)UTF8Length
{
    return (unsigned int) [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) toHexString:(unsigned char*) data length: (unsigned int) length {
    NSMutableString* hash = [NSMutableString stringWithCapacity:length * 2];
    for (unsigned int i = 0; i < length; i++) {
        [hash appendFormat:@"%02x", data[i]];
        data[i] = 0;
    }
    return hash;
}

- (BOOL)isValidEmailWithStricterFilter:(BOOL)stricterFilter
{
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isNilOrEmpty {
    return (self == nil || [self isEqualToString:@""] || self == [NSNull null]);
}

- (BOOL)isEmpty {
    return [[self noSpaceString] isEqualToString:@""];
}

- (NSUInteger)numberOfLines
{
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

- (NSDate *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    return [dateFormatter dateFromString:self];
}

- (NSDate *)dateWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:self];
}

- (NSDate *)scanDate {
    __block NSDate *detectedDate;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes error:nil];
    [detector enumerateMatchesInString:self
                               options:kNilOptions
                                 range:NSMakeRange(0, [self length])
                            usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     { detectedDate = result.date; }];
    return detectedDate;
}

- (NSString *)noSpaceString {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end