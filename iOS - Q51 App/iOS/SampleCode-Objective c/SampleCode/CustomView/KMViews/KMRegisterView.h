//
//  KMRegisterView.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 17/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMScrollView.h"

@protocol RegisterDelegate;

@class KMButton;

typedef void (^RegisterActionBlock) (KMButton *button);
typedef void (^LoginActionBlock) (KMButton *button);

@interface KMRegisterView : KMScrollView

@property (nonatomic, strong) KMButton *loginButton;
@property (nonatomic, strong) KMButton *signUpButton;
@property (nonatomic, strong) RegisterActionBlock registerBlock;
@property (nonatomic, strong) LoginActionBlock loginBlock;
@property (nonatomic, strong) id<RegisterDelegate> delegate;

- (NSDictionary *)userDetails;
- (void)clearFields;
- (BOOL)isValidDetails;
- (void)registerWithUsername:(NSString *)username andPassword:(NSString *)password;
- (NSArray *)fields;
- (void)keyboardAppearedWithNotification:(NSNotification *)notification andFields:(NSArray *)fields;
- (void)hideKeyboard;

@end

@protocol RegisterDelegate <NSObject>

- (void)registerView:(KMRegisterView *)view didClickSignupButton:(KMButton *)button;

@end