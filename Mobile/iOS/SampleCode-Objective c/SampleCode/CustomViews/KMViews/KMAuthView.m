//
//  KMAuthView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMAuthView.h"
#import "KMFloatingTextField.h"
#import "KMCheckBox.h"
#import "Themes.h"
#import "UIColor+KMKit.h"
#import "Macros.h"
#import "Strings.h"
#import "FontAwesomeKit.h"
#import "KMButton.h"
#import "Util.h"
#import "NSString+KMKit.h"
#import "UIScrollView+KMKit.h"
#import "TKRoundedView.h"
#import "KMFloatingTextField+KMKit.h"

@interface KMAuthView () <UITextFieldDelegate>

@property (nonatomic, strong) KMFloatingTextField *txtUsername;
@property (nonatomic, strong) KMFloatingTextField *txtPassword;
@property (nonatomic, strong) KMCheckBox *rememberChkBox;

@property (assign, nonatomic) CGRect keyboardFrame;
//@property (nonatomic, strong) NSArray *inputFields;

@property BOOL valid;

@end

@implementation KMAuthView

- (BOOL)isValidDetails {
    return _valid;
}

- (void)configure {
    _valid = NO;
    
    self.backgroundColor = [UIColor colorFromHexCode:APP_SECONDARY_COLOR];
    
    [[self scrollContainer] addSubview:[self txtUsername]];
    [[self scrollContainer] addSubview:[self txtPassword]];
    [[self scrollContainer] addSubview:[self rememberChkBox]];
    [[self scrollContainer] addSubview:[self loginButton]];
    
    UILabel *lblOr = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY([self loginButton]) + 2, 320, 30)];
    [lblOr setText:@"Don't have an account yet ?"];
    [lblOr setTextColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
    [lblOr setTextAlignment:NSTextAlignmentCenter];
    [[self scrollContainer] addSubview:lblOr];
    
    [[self scrollContainer] addSubview:[self signUpButton]];
    [[self scrollContainer] setContentSize:CGSizeMake(WIDTH(self), MaxY([self signUpButton]))];
}

- (NSArray *)fields {
    return @[[self txtUsername], [self txtPassword]];
}

//- (NSArray *)inputFields {
//    _inputFields = nil;
//    if (!_inputFields) {
//        _inputFields = @[[self txtUsername], [self txtPassword]];
//    }
//    return _inputFields;
//}

- (KMFloatingTextField *)txtUsername {
    if (!_txtUsername) {
        _txtUsername = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(40, 5, 240, 40)];
        [_txtUsername setFont:[UIFont systemFontOfSize:14.0f]];
        _txtUsername.placeholder = @"Username or Email";
        _txtUsername.placeholderTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.floatingLabelActiveTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.floatingLabelTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.textAlignment = NSTextAlignmentLeft;
        _txtUsername.keyboardType = UIKeyboardTypeEmailAddress;
        _txtUsername.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtUsername.delegate = self;
        _txtUsername.tag = 1001;
        _txtUsername.textColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];

        [_txtUsername addLineView];
        
        FAKIcon *emailIcon = [FAKIonIcons ios7EmailOutlineIconWithSize:iconHeight];
        [emailIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        UIImage *emailImage = [emailIcon imageWithSize:CGSizeMake(iconHeight, iconHeight)];
        [_txtUsername addIcon:emailImage];
    }
    
    return _txtUsername;
}

- (KMFloatingTextField *)txtPassword {
    if (!_txtPassword) {
        _txtPassword = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(40, MaxY([self txtUsername]) + 15, 240, 40)];
        [_txtPassword setFont:[UIFont systemFontOfSize:14.0f]];
        _txtPassword.placeholder = @"Password";
        _txtPassword.secureTextEntry = YES;
        _txtPassword.placeholderTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtPassword.floatingLabelActiveTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtPassword.floatingLabelTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtPassword.textAlignment = NSTextAlignmentLeft;
        _txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassword.delegate = self;
        _txtPassword.tag = 1002;
        _txtPassword.textColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];

        [_txtPassword addLineView];
        
        FAKIcon *passwordIcon = [FAKIonIcons ios7LockedOutlineIconWithSize:iconHeight];
        [passwordIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        UIImage *passwordImage = [passwordIcon imageWithSize:CGSizeMake(iconHeight, iconHeight)];
        [_txtPassword addIcon:passwordImage];
    }
    
    return _txtPassword;
}

- (KMCheckBox *)rememberChkBox {
    if (!_rememberChkBox) {
        _rememberChkBox = [[KMCheckBox alloc] initWithTitle:@"Remember Me" andHeight:30];
        [_rememberChkBox setCheckAlignment:KMCheckboxAlignmentLeft];
        [_rememberChkBox.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_rememberChkBox.titleLabel setTextColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        [_rememberChkBox setStrokeColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        [_rememberChkBox setCheckColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        _rememberChkBox.frame = CGRectMake(40, MaxY([self txtPassword]) + 25, 240, 20);
        [_rememberChkBox addObserver:self forKeyPath:@"checkState" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _rememberChkBox;
}

- (void)hideKeyboard {
    [[self txtUsername] resignFirstResponder];
    [[self txtPassword] resignFirstResponder];
}

- (NSDictionary *)userDetails {
    return @{@"user_name": [[self txtUsername].text lowercaseString], @"password":[self txtPassword].text};
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"checkState"]) {
        keepMeSignedIn = ([self rememberChkBox].checkState == KMCheckboxStateChecked)?YES:NO;
    }
}

- (BOOL)isRemembered {
    return [self rememberChkBox].checkState == KMCheckboxStateChecked;
}

- (UIImage *)buttonNormalImage {
    FAKIcon *rightMark = [FAKIonIcons ios7CheckmarkOutlineIconWithSize:30.0f];
    [rightMark addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_SECONDARY_COLOR]];
    UIImage *normalRightMark = [rightMark imageWithSize:CGSizeMake(30.0f, 30.0f)];
    
    return normalRightMark;
}

- (UIImage *)buttonHighlightedImage {
    FAKIcon *rightMark = [FAKIonIcons ios7CheckmarkOutlineIconWithSize:30.0f];
    [rightMark addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
    UIImage *highlightedRightMark = [rightMark imageWithSize:CGSizeMake(30.0f, 30.0f)];
    return highlightedRightMark;
}

- (KMButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[KMButton alloc] initWithFrame:CGRectMake(35, MaxY([self rememberChkBox]) + 20, 250, 40)];
        _loginButton.buttonTitle = @"Log In";
        [_loginButton invertBackgroundImage];
        [_loginButton setImage:[self buttonNormalImage] forState:UIControlStateNormal];
        [_loginButton setImage:[self buttonHighlightedImage] forState:UIControlStateHighlighted];
        [_loginButton addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.actionBlock = ^(KMButton *button){

        };
    }
    return _loginButton;
}

- (KMButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [[KMButton alloc] initWithFrame:CGRectMake(35, MaxY([self loginButton]) + 35, 250, 40)];
        _signUpButton.buttonTitle = @"Register Me";
        [_signUpButton invertBackgroundImage];
    }
    return _signUpButton;
}

- (void)setLoginBlock:(LoginActionBlock)loginBlock {
    _loginBlock = loginBlock;
    [self loginButton].actionBlock = _loginBlock;
}

- (void)setSignupBlock:(RegisterActionBlock)signupBlock {
    _signupBlock = signupBlock;
    [self signUpButton].actionBlock = _signupBlock;
}

- (void)loginUser:(id)sender {
    [self loginButton].enabled = NO;
    
    NSString *username = [self txtUsername].text;
    NSString *password = [self txtPassword].text;
    
    if (keepMeSignedIn) {
        NSDictionary *credentials = @{@"Username": username, @"Password": password};
        setUserDefaultObject(credentials, kRememberKey);
    }
    else {
        setUserDefaultObject(nil, kRememberKey);
    }
    
    BOOL invalid = [self checkCredentials:username password:password usernameAsEmail:NO];

    _valid = (invalid == FALSE);
    
    if (_loginBlock && !invalid) {
        _loginBlock([self loginButton]);
    }
    else {
        [self loginButton].enabled = YES;
    }
}

- (BOOL)shakeView:(UIView *)view {
    return [[Util sharedInstance] addShakeAnimationForView:view withDuration:kAFViewShakerDefaultDuration];
}

- (BOOL)checkCredentials:(NSString *)username password:(NSString *)password usernameAsEmail:(BOOL)isEmail {
    
    BOOL Invalid = NO;
    
    Invalid = [username isNilOrEmpty]?[self shakeView:[self txtUsername]]:isEmail?![username isValidEmailWithStricterFilter:NO]?[self shakeView:[self txtUsername]]:NO:NO;
    Invalid = Invalid?([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):YES):([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):NO);
    
    return Invalid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[self txtUsername] resignFirstResponder];
    [[self txtPassword] resignFirstResponder];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
    [[self scrollContainer] scrollRectToVisible:frameToScroll animated:YES];
}

- (void)clearFields {
    [self txtUsername].text = @"";
    [self txtPassword].text = @"";
    _rememberChkBox.checkState = KMCheckboxStateUnchecked;
}

- (void)loginFromSavedDetails {
    NSDictionary *credentials = UserDefaultObject(kRememberKey);
    _txtUsername.text = [credentials objectForKey:@"Username"];
    _txtPassword.text = [credentials objectForKey:@"Password"];
    
    [self loginUser:[self loginButton]];
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password {
    _txtUsername.text = username;
    _txtPassword.text = password;
    
    [self loginUser:[self loginButton]];
}

#pragma mark - Keyboard methods

//- (void)keyboardWillChangeFrame:(NSNotification *)notification {
//    
//    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.keyboardFrame = [[self scrollContainer].superview convertRect:keyboardEndFrame fromView:nil];
//    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
//    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
//    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    CGRect newFrame = [self scrollContainer].frame;
//    newFrame.size.height = self.keyboardFrame.origin.y;
//    
//    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
//        [self scrollContainer].frame = newFrame;
//    } completion:^(BOOL finished) {
//        NSUInteger indexOfActiveTextFiled = [self.inputFields indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
//            return textField.isFirstResponder;
//        }];
//        if (indexOfActiveTextFiled != NSNotFound) {
//            UITextField *textField = self.inputFields[indexOfActiveTextFiled];
//            CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
//            [self scrollRectToVisible:frameToScroll animated:YES];
//        }
//    }];
//}

#pragma mark - Other methods

- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    
    if (rect.size.height > self.keyboardFrame.origin.y) {
        rect.size.height = self.keyboardFrame.origin.y;
    }
    
    [[self scrollContainer] km_ScrollRectToVisibleCenteredOn:rect animated:YES];
}

- (void)keyboardAppearedWithNotification:(NSNotification *)notification andFields:(NSArray *)fields {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardFrame = [[self scrollContainer].superview convertRect:keyboardEndFrame fromView:nil];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = [self scrollContainer].frame;
    newFrame.size.height = self.keyboardFrame.origin.y;
    
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        [self scrollContainer].frame = newFrame;
    } completion:^(BOOL finished) {
        NSUInteger indexOfActiveTextFiled = [fields indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
            return textField.isFirstResponder;
        }];
        if (indexOfActiveTextFiled != NSNotFound) {
            UITextField *textField = fields[indexOfActiveTextFiled];
            CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
            [self scrollRectToVisible:frameToScroll animated:YES];
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
