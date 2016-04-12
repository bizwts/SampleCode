//
//  User.h
//  TapCard
//
//  Created by WTS on 15/09/15.
//  Copyright (c) 2015 WTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSInteger userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *workNumber;
@property (nonatomic, strong) NSString *mobileNumber;
@property (nonatomic, strong) NSString *faxNumber;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *avatar;
@property BOOL rememberMe;

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSDictionary *)userDictionaryFromUser:(User *)user;


@end
