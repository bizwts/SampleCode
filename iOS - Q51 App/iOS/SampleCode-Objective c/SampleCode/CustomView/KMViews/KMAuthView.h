//
//  KMAuthView.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMScrollView.h"

@class KMButton;

typedef void (^LoginActionBlock) (KMButton *button);
typedef void (^RegisterActionBlock) (KMButton *button);

@interface KMAuthView : KMScrollView

@property (nonatomic, strong) KMButton *loginButton;
@property (nonatomic, strong) KMButton *signUpButton;
@property (nonatomic, strong) LoginActionBlock loginBlock;
@property (nonatomic, strong) RegisterActionBlock signupBlock;

- (NSDictionary *)userDetails;
- (void)clearFields;
- (BOOL)isValidDetails;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
- (NSArray *)fields;
- (void)keyboardAppearedWithNotification:(NSNotification *)notification andFields:(NSArray *)fields;
- (void)hideKeyboard;

@end
