//
//  DLoginValidation.m
//  BoBL
//
//  Created by WTS on 07/11/15.
//  Copyright (c) 2015 WingsTechSolutions. All rights reserved.
//

#import "DLoginValidation.h"

@implementation DLoginValidation

+ (BOOL)checkEmail:(NSString *)emailID {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailID];
}
+ (BOOL)checkPWD:(NSString *)pwd {
    //NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    //NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    if ( [pwd length]<6 || [pwd length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )
        return NO;  // no number;
    return YES;
}
//0 email
//1 pwd
//2 success
+ (NSInteger)checkLogin:(NSString *)emailID pwd:(NSString *)pwd {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
   
    if ([emailTest evaluateWithObject:emailID]) {
        if ( [pwd length]<2 || [pwd length]>20 )
            return 1;
        else
            return 2;
    }else
        return 0;
    
    
}

@end
