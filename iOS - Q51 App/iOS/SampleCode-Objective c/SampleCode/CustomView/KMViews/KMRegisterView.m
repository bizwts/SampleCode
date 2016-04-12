//
//  KMRegisterView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 17/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMRegisterView.h"
#import "KMFloatingTextField.h"
#import "Themes.h"
#import "UIColor+KMKit.h"
#import "Macros.h"
#import "KMButton.h"
#import "FontAwesomeKit.h"
#import "Util.h"
#import "NSString+KMKit.h"  
#import "UIScrollView+KMKit.h"
#import "Strings.h"
#import "KMFloatingTextField+KMKit.h"

@interface KMRegisterView () <UITextFieldDelegate>

@property (nonatomic, strong) KMFloatingTextField *txtUsername;
@property (nonatomic, strong) KMFloatingTextField *txtPassword;
@property (nonatomic, strong) KMFloatingTextField *txtConfirmPassword;

@property (assign, nonatomic) CGRect keyboardFrame;
//@property (nonatomic, strong) NSArray *inputFields;

@property BOOL valid;

@end

@implementation KMRegisterView

- (BOOL)isValidDetails {
    return _valid;
}

- (void)configure {
    
    _valid = NO;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.backgroundColor = [UIColor colorFromHexCode:APP_SECONDARY_COLOR];
    
    [[self scrollContainer] addSubview:[self txtUsername]];
    [[self scrollContainer] addSubview:[self txtPassword]];
    [[self scrollContainer] addSubview:[self txtConfirmPassword]];
    [[self scrollContainer] addSubview:[self signUpButton]];
    
    UILabel *lblOr = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY([self signUpButton]) + 2, 320, 30)];
    [lblOr setText:@"Already have an account ?"];
    [lblOr setTextColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
    [lblOr setTextAlignment:NSTextAlignmentCenter];
    [[self scrollContainer] addSubview:lblOr];
    
    [[self scrollContainer] addSubview:[self loginButton]];
    [[self scrollContainer] setContentSize:CGSizeMake(WIDTH(self), MaxY([self loginButton]))];
    
//    self.inputFields = @[[self txtUsername], [self txtPassword], [self txtConfirmPassword]];
}

- (NSArray *)fields {
    return @[[self txtUsername], [self txtPassword], [self txtConfirmPassword]];
}

//- (NSArray *)inputFields {
//    if (_inputFields) _inputFields = nil;
//    if (!_inputFields) {
//        _inputFields = @[[self txtUsername], [self txtPassword], [self txtConfirmPassword]];
//    }
//    return _inputFields;
//}

- (KMFloatingTextField *)txtUsername {
    if (!_txtUsername) {
        _txtUsername = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(40, 5, 240, 40)];
        [_txtUsername setFont:[UIFont systemFontOfSize:14.0f]];
        _txtUsername.placeholder = @"Username";
        _txtUsername.placeholderTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.floatingLabelActiveTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.floatingLabelTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtUsername.textAlignment = NSTextAlignmentLeft;
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

- (KMFloatingTextField *)txtConfirmPassword {
    if (!_txtConfirmPassword) {
        _txtConfirmPassword = [[KMFloatingTextField alloc] initWithFrame:CGRectMake(40, MaxY([self txtPassword]) + 15, 240, 40)];
        [_txtConfirmPassword setFont:[UIFont systemFontOfSize:14.0f]];
        _txtConfirmPassword.placeholder = @"Password";
        _txtConfirmPassword.secureTextEntry = YES;
        _txtConfirmPassword.placeholderTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtConfirmPassword.floatingLabelActiveTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtConfirmPassword.floatingLabelTextColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        _txtConfirmPassword.textAlignment = NSTextAlignmentLeft;
        _txtConfirmPassword.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtConfirmPassword.delegate = self;
        _txtConfirmPassword.tag = 1002;
        _txtConfirmPassword.textColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
        
        [_txtConfirmPassword addLineView];
        
        FAKIcon *passwordIcon = [FAKIonIcons ios7LockedOutlineIconWithSize:iconHeight];
        [passwordIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:APP_PRIMARY_COLOR]];
        UIImage *passwordImage = [passwordIcon imageWithSize:CGSizeMake(iconHeight, iconHeight)];
        [_txtConfirmPassword addIcon:passwordImage];
    }
    
    return _txtConfirmPassword;
}

- (NSDictionary *)userDetails {
    return @{@"user_name": [[self txtUsername].text lowercaseString], @"password":[self txtPassword].text};
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
        _loginButton = [[KMButton alloc] initWithFrame:CGRectMake(35, MaxY([self signUpButton]) + 30, 250, 40)];
        _loginButton.buttonTitle = @"Log In";
        [_loginButton invertBackgroundImage];
        _loginButton.actionBlock = ^(KMButton *button){
            
        };
    }
    return _loginButton;
}

- (KMButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [[KMButton alloc] initWithFrame:CGRectMake(35, MaxY([self txtConfirmPassword]) + 35, 250, 40)];
        _signUpButton.buttonTitle = @"Register Me";
        [_signUpButton setImage:[self buttonNormalImage] forState:UIControlStateNormal];
        [_signUpButton setImage:[self buttonHighlightedImage] forState:UIControlStateHighlighted];
        [_signUpButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
        [_signUpButton invertBackgroundImage];
        _signUpButton.actionBlock = ^(KMButton *button){
            NSLog(@"Sign Up Button Clicked");
        };
    }
    return _signUpButton;
}

- (void)setRegisterBlock:(RegisterActionBlock)registerBlock {
    _registerBlock = registerBlock;
    [self signUpButton].actionBlock = _registerBlock;
}

- (void)setLoginBlock:(RegisterActionBlock)loginBlock {
    _loginBlock = loginBlock;
    [self loginButton].actionBlock = _loginBlock;
}

- (void)registerUser:(id)sender {
//    [self signUpButton].enabled = NO;
    
    NSString *username = [self txtUsername].text;
    NSString *password = [self txtPassword].text;
    NSString *confirm = [self txtConfirmPassword].text;
    
    NSLog(@"password length = %lu",(unsigned long)[[self txtPassword].text length]);
    
    BOOL invalid = [self checkCredentials:username password:password matchPassword:confirm usernameAsEmail:NO];
    
    _valid = (invalid == FALSE);

    if (!invalid) {
        if ([self.delegate respondsToSelector:@selector(registerView:didClickSignupButton:)])
            [self.delegate registerView:self didClickSignupButton:sender];
    }
    
    if (_registerBlock && !invalid) {
        _registerBlock([self signUpButton]);
    }
    else {
        [self signUpButton].enabled = YES;
    }
}

- (void)registerWithUsername:(NSString *)username andPassword:(NSString *)password {
    _txtUsername.text = username;
    _txtPassword.text = password;
    _txtConfirmPassword.text = password;
    
    [self registerUser:[self signUpButton]];
}

- (BOOL)shakeView:(UIView *)view {
    return [[Util sharedInstance] addShakeAnimationForView:view withDuration:kAFViewShakerDefaultDuration];
}

- (BOOL)checkCredentials:(NSString *)username password:(NSString *)password matchPassword:(NSString *)match usernameAsEmail:(BOOL)isEmail {
    
    BOOL Invalid = NO;
    
    Invalid = [username isNilOrEmpty]?[self shakeView:[self txtUsername]]:isEmail?![username isValidEmailWithStricterFilter:NO]?[self shakeView:[self txtUsername]]:NO:NO;
    Invalid = Invalid?([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):YES):([password isNilOrEmpty]?([self shakeView:[self txtPassword]]?YES:YES):NO);
    Invalid = Invalid?([match isNilOrEmpty]?[self shakeView:[self txtConfirmPassword]]:(![match isEqualToString:password]?[self shakeView:[self txtConfirmPassword]]:YES)):([match isNilOrEmpty]?[self shakeView:[self txtConfirmPassword]]:(![match isEqualToString:password]?[self shakeView:[self txtConfirmPassword]]:NO));
    
    return Invalid;
}

- (void)hideKeyboard {
    [[self txtUsername] resignFirstResponder];
    [[self txtPassword] resignFirstResponder];
    [[self txtConfirmPassword] resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[self txtUsername] resignFirstResponder];
    [[self txtPassword] resignFirstResponder];
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect frameToScroll = [[self scrollContainer] convertRect:textField.frame fromView:textField.superview];
    NSLog(@"frame to scroll = %@",NSStringFromCGRect(frameToScroll));
    [[self scrollContainer] scrollRectToVisible:frameToScroll animated:YES];
    NSString *deviceModel = (NSString*)[UIDevice currentDevice].model;
    if ([[deviceModel substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"iPad"]) {
        [[self scrollContainer] setContentOffset:CGPointMake(0, frameToScroll.origin.y > 50?frameToScroll.origin.y - 20:0)];
    }
}

- (void)clearFields {
    [self txtUsername].text = @"";
    [self txtPassword].text = @"";
    [self txtConfirmPassword].text = @"";
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
    NSLog(@"new frame = %@",NSStringFromCGRect(newFrame));
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
