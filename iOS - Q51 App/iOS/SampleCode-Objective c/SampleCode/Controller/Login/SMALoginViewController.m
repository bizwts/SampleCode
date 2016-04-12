//
//  SMALoginViewController.m
//  SignMe
//
//  Created by WTS on 03/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "SMALoginViewController.h"
#import "Macros.h"
#import "DMTextField.h"
#import "Themes.h"
#import "UIImage+KMKit.h"
#import "SMARegisterFirstViewController.h"
#import "PNTToolbar.h"
#import "Switch.h"
#import "CAFFImageSwitch.h"
#import "AppDelegate.h"
#import "JTMaterialSwitch.h"
#import "SMARegisterTypeViewController.h"
#import "SMAViewActorProfileViewController.h"
#import "serverAPIClass.h"
#import "RSBJSON.h"
#import "Constants.h"
#import "SMAViewActorProfileViewController.h"
#import "SMAListOfActorViewController.h"
#import "SVProgressHUD.h"
#import "SMAForgotPasswordViewController.h"
#import "BSErrorMessageView.h"
#import "UITextField+BSErrorMessageView.h"
#import "AFNetworking.h"
#import "API.h"

@interface SMALoginViewController()<UITextFieldDelegate, UIAlertViewDelegate> {
    NSString *strEmail,*strPassword;
    NSString *strRememberMe;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) DMTextField *txtEmailId;
@property (nonatomic, strong) DMTextField *txtPassword;
@property (nonatomic, strong) UIButton *btnForgotPassword;
@property (nonatomic, strong) UIButton *btnLogin;
@property (nonatomic, strong) UIButton *btnRegister;
@property (nonatomic, strong) JTMaterialSwitch *swithcRemember;
@property (nonatomic, strong) UILabel *lblRememberMe;
@end

@implementation SMALoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    strRememberMe = @"0";
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(addUIControl) withObject:nil afterDelay:0.0];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = true;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)addUIControl {
    [self.view addSubview:[self scrollView]];
    [[self scrollView] addSubview:[self imgLogo]];
    [[self scrollView] addSubview:[self txtEmailId]];
    [[self scrollView] addSubview:[self txtPassword]];
    [[self scrollView] addSubview:[self swithcRemember]];
    [[self scrollView] addSubview:[self btnLogin]];
    
    _scrollView.contentSize = CGSizeMake(WIDTH(self.view), MaxY(_btnLogin) + 100);
    [self setupKeyboardSettings];
}

- (JTMaterialSwitch *)swithcRemember {
    if (!_swithcRemember) {
        _swithcRemember = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeNormal style:JTMaterialSwitchStyleDefault state:JTMaterialSwitchStateOff];
        _swithcRemember.frame = CGRectMake((MinX(_txtPassword.txtField) - 50) / 2, MaxY(_txtPassword) + 20, 50, 30);
        _swithcRemember.thumbOnTintColor  = BaseColor;
        _swithcRemember.thumbOffTintColor = [UIColor colorWithRed:232./255. green:233./255. blue:232./255. alpha:1.0];
        _swithcRemember.trackOnTintColor  = BaseColor;
        _swithcRemember.trackOffTintColor = [UIColor colorWithRed:164./255. green:164./255. blue:164./255. alpha:1.0];
        _swithcRemember.rippleFillColor = BaseColor;
        _swithcRemember.isRippleEnabled = true;
        [_swithcRemember addTarget:self action:@selector(stateChanged) forControlEvents:UIControlEventValueChanged];
        
        _lblRememberMe = [[UILabel alloc] initWithFrame:CGRectMake(X(_txtEmailId.txtField) + 5 , MaxY(_txtPassword) + 20, 100, 30)];
        _lblRememberMe.text = @"Remember me";
        _lblRememberMe.textColor = GrayColor;
        _lblRememberMe.textAlignment = NSTextAlignmentCenter;
        _lblRememberMe.font = [UIFont systemFontOfSize:14.0f];
        [_scrollView addSubview:_lblRememberMe];
    }
    return _swithcRemember;
}

- (void)stateChanged {
    if (_swithcRemember.isOn) {
        strRememberMe = @"1";
        _lblRememberMe.textColor = BaseColor;
    }else {
        _lblRememberMe.textColor = GrayColor;
        strRememberMe = @"0";
    }
}

- (UIImageView *)imgLogo {
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH(self.view) - 200) / 2, 20, 200, 150)];
        _imgLogo.image = [UIImage imageNamed:@"logo"];
        _imgLogo.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgLogo;
}

- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[_txtEmailId.txtField,
                            _txtPassword.txtField];
    toolbar.mainScrollView.contentSize = CGSizeMake(WIDTH(self.view), MaxY(_btnRegister) + 20);
    [_scrollView setContentSize:CGSizeMake(WIDTH(self.view), MaxY(_btnRegister) + 20)];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    }
    return _scrollView;
}

- (DMTextField *)txtEmailId {
    if (!_txtEmailId) {
        _txtEmailId = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_imgLogo) + 10, WIDTH(self.view) - 20, 40) data:@"Email Id"];
        _txtEmailId.txtField.tag = 0;
        _txtEmailId.txtField.font = [UIFont systemFontOfSize:14.0f];
        _txtEmailId.txtField.delegate = self;
        _txtEmailId.txtField.keyboardType = UIKeyboardTypeEmailAddress;
        
        BSErrorMessageView *errorMessageView = [BSErrorMessageView errorMessageViewWithMessage:@"Enter proper formate"];
        errorMessageView.mainTintColor = [UIColor redColor];
        errorMessageView.textFont = [UIFont systemFontOfSize:8.0f];
        [_txtEmailId.txtField bs_setupErrorMessageViewWithView:errorMessageView];
    }
    return _txtEmailId;
}

- (DMTextField *)txtPassword {
    if (!_txtPassword) {
        _txtPassword = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtEmailId) + 10, WIDTH(self.view) - 20, 40) data:@"Password"];
        _txtPassword.txtField.delegate = self;
        _txtPassword.txtField.tag = 1;
        _txtPassword.txtField.font = [UIFont systemFontOfSize:14.0f];
        _txtPassword.txtField.secureTextEntry = true;
        _txtPassword.txtField.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtPassword.txtField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _txtPassword.txtField.keyboardType = UIKeyboardTypeEmailAddress;
        
        BSErrorMessageView *errorMessageView = [BSErrorMessageView errorMessageViewWithMessage:@"Enter proper password"];
        errorMessageView.mainTintColor = [UIColor redColor];
        errorMessageView.textFont = [UIFont systemFontOfSize:8.0f];
        [_txtPassword.txtField bs_setupErrorMessageViewWithView:errorMessageView];
    }
    return _txtPassword;
}

- (UIButton *)btnLogin {
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLogin.frame = CGRectMake(20, MaxY(_swithcRemember) + 20, WIDTH(self.view) - 40, 50);
        _btnLogin.tag = 1;
        [_btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnLogin addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchUpInside];
        _btnLogin.layer.cornerRadius = HEIGHT(_btnLogin) / 2;
        _btnLogin.layer.masksToBounds = YES;
        [_btnLogin setBackgroundImage:[UIImage imageWithColor:BaseColor cornerRadius:HEIGHT(_btnLogin) / 2] forState:UIControlStateNormal];
        [_btnLogin setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:HEIGHT(_btnLogin) / 2] forState:UIControlStateHighlighted];
        [_btnLogin setTitleColor:BaseColor forState:UIControlStateHighlighted];
        _btnLogin.layer.borderColor = BaseColor.CGColor;
        _btnLogin.layer.borderWidth = 1.0f;
    }
    return _btnLogin;
}

- (void)clearField {
    _txtEmailId.txtField.text = @"";
    _txtPassword.txtField.text = @"";
}

- (void)didTappedButton:(UIButton *)sender {
    switch (sender.tag) {
        case 0:        {
            [self clearField];
            strRememberMe = @"0";
            SMAForgotPasswordViewController *forgot = [[SMAForgotPasswordViewController alloc] init];
            [self.navigationController pushViewController:forgot animated:true];
        }
            break;
        case 1:
            [self performSelector:@selector(doLoing) withObject:self afterDelay:0.0];
            break;
        case 2:        {
            SMARegisterTypeViewController *reg = [[SMARegisterTypeViewController alloc]init];
            [self.navigationController pushViewController:reg animated:true];
        }
            break;
        default:
            break;
    }
}

#pragma mark- Password Validation check

-(BOOL)isPasswordValid:(NSString *)pwd {
    if ( [pwd length]<5)
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

- (void)doLoing {
    strEmail = [_txtEmailId.txtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strPassword = [_txtPassword.txtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if (strEmail.length == 0) {
        [_txtEmailId.txtField bs_setupErrorMessageViewWithMessage:@"Please enter email address."];
        [_txtEmailId.txtField bs_showError];
    }
    else if ([emailTest evaluateWithObject:strEmail] == NO) {
        [_txtEmailId.txtField bs_setupErrorMessageViewWithMessage:@"Please enter valid email."];
        [_txtEmailId.txtField bs_showError];
    }
    if(strPassword.length == 0) {
        [_txtPassword.txtField bs_setupErrorMessageViewWithMessage:@"Please enter password."];
        [_txtPassword.txtField bs_showError];
    }
    if ([emailTest evaluateWithObject:strEmail] && strPassword.length > 0) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [self performSelector:@selector(CallLoginAPI) withObject:self afterDelay:0.0];
        
    }
}

- (void)CallLoginAPI {
    NSString *pass=[[AppDelegate sharedDelegate] sha512:strPassword];
    NSDictionary *datadic = @{@"email":strEmail,@"password":pass};
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setStringEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=serializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    NSString *apiLogin = [NSString stringWithFormat:@"%@app/authentication/login",BASEPATH];
    [manager POST:apiLogin parameters:datadic success:^(AFHTTPRequestOperation *operation, id responseObject)                 {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject = %@",responseObject);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error.description);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
    switch (textField.tag) {
        case 0:
            _txtEmailId.hLine.backgroundColor = BaseColor;
            break;
        case 1:
            _txtPassword.hLine.backgroundColor = BaseColor;
            break;
        default:
            break;
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.textColor = GrayColor;
    if (textField.text.length>0)
        [textField bs_hideError];
    switch (textField.tag) {
        case 0:
            _txtEmailId.hLine.backgroundColor = GrayColor;
            break;
        case 1:
            _txtPassword.hLine.backgroundColor = GrayColor;
            break;
        default:
            break;
    }
    return true;
}


@end
