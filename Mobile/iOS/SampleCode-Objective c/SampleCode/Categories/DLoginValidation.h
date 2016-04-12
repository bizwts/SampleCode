//
//  DLoginValidation.h
//  BoBL
//
//  Created by WTS on 07/11/15.
//  Copyright (c) 2015 WingsTechSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLoginValidation : NSObject


+ (BOOL)checkEmail:(NSString *)emailID;
+ (BOOL)checkPWD:(NSString *)pwd;
+ (NSInteger)checkLogin:(NSString *)emailID pwd:(NSString *)pwd;

@end
