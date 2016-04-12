//
//  User.m
//  TapCard
//
//  Created by WTS on 15/09/15.
//  Copyright (c) 2015 WTS. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _userId = [[dic valueForKey:@"u_id"] integerValue];
        _username = [dic valueForKey:@"u_username"];
        _firstname = [dic valueForKey:@"u_firstname"];
        _lastname = [dic valueForKey:@"u_lastname"];
        _email = [dic valueForKey:@"u_email"];
        _faxNumber = [dic valueForKey:@"u_faxnumber"];
        _mobileNumber = [dic valueForKey:@"u_mobilenumber"];
        _workNumber = [dic valueForKey:@"u_worknumber"];
        _address = [dic valueForKey:@"u_address"];
        _website = [dic valueForKey:@"u_website"];
        _avatar = [dic valueForKey:@"u_profilepicture"];
    }
    return self;
}

- (NSDictionary *)userDictionaryFromUser:(User *)user {
    NSDictionary *dic = @{@"u_id":[NSString stringWithFormat:@"%ld",(long)_userId],
                          @"u_email":_email,
                          @"u_username":_username,
                          @"u_firstname":_firstname,
                          @"u_lastname":_lastname,
                          @"u_worknumber":_workNumber,
                          @"u_faxnumber":_faxNumber,
                          @"u_website":_website,
                          @"u_mobilenumber":_mobileNumber,
                          @"u_address":_address,
                          @"u_profilepicture":_avatar};
    return dic;
}

@end
