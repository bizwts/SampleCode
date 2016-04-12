//
//  UpdateActorBasicDetailsView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "UpdateActorBasicDetailsView.h"

@implementation UpdateActorBasicDetailsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        [self addUIControl];
    }
    return self;
}

- (void)addUIControl {
    [self addSubview:[self scrollView]];
    [[self scrollView] addSubview:[self txtEmailId]];
    [[self scrollView] addSubview:[self txtFirstName]];
    [[self scrollView] addSubview:[self txtMiddleName]];
    [[self scrollView] addSubview:[self txtLastName]];
    [[self scrollView] addSubview:[self txtContactNo]];
    [[self scrollView] addSubview:[self txtCity]];
    [[self scrollView] addSubview:[self txtState]];
    
    [self updateData];
    
    [[self scrollView] addSubview:[self btnSave]];
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
    
    [self setupKeyboardSettings];
}
//RBMAR20
//RBAPP100
- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[
                            _txtFirstName.txtField,
                            _txtMiddleName.txtField,
                            _txtLastName.txtField,
                            _txtContactNo.txtField,
                            _txtCity.txtField,
                            _txtState.txtField,];
    [_scrollView setContentSize:CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20)];
}

- (UIButton *)btnSave {
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(20, MaxY(_txtState) + 20, WIDTH(self) - 40, 50);
        [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSave addTarget:self action:@selector(didTappedActorBasicDetailSaveButton:) forControlEvents:UIControlEventTouchUpInside];
        _btnSave.layer.cornerRadius = 25;
        _btnSave.layer.masksToBounds = YES;
        [_btnSave setBackgroundImage:[UIImage imageWithColor:BaseColor cornerRadius:4] forState:UIControlStateNormal];
        [_btnSave setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:25] forState:UIControlStateHighlighted];
        [_btnSave setTitleColor:BaseColor forState:UIControlStateHighlighted];
        _btnSave.layer.borderColor = BaseColor.CGColor;
        _btnSave.layer.borderWidth = 1.0f;
    }
    return _btnSave;
}

- (void)didTappedBasicDetailSaveButton:(UIButton *)sender {
    NSLog(@"didTappedBasicDetailSaveButton");
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
    }
    return _scrollView;
}

- (DMTextField *)txtEmailId {
    if (!_txtEmailId) {
        _txtEmailId = [[DMTextField alloc] initWithFrame:CGRectMake(10, 10, WIDTH(self) - 20, 40) data:@"Email Id"];
        _txtEmailId.txtField.delegate = self;
        _txtEmailId.txtField.tag = 0;
        _txtEmailId.userInteractionEnabled = false;
    }
    return _txtEmailId;
}

- (DMTextField *)txtFirstName {
    if (!_txtFirstName) {
        _txtFirstName = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtEmailId) + 20, WIDTH(self) - 20, 40) data:@"First name"];
        _txtFirstName.txtField.delegate = self;
        _txtFirstName.txtField.tag = 0;
    }
    return _txtFirstName;
}

- (DMTextField *)txtMiddleName {
    if (!_txtMiddleName) {
        _txtMiddleName = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtFirstName) + 10, WIDTH(self) - 20, 40) data:@"Middle Name"];
        _txtMiddleName.txtField.delegate = self;
        _txtMiddleName.txtField.tag = 1;
    }
    return _txtMiddleName;
}

- (DMTextField *)txtLastName {
    if (!_txtLastName) {
        _txtLastName = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtMiddleName) + 10, WIDTH(self) - 20, 40) data:@"Last name"];
        _txtLastName.txtField.delegate = self;
        _txtLastName.txtField.tag = 2;
    }
    return _txtLastName;
}

- (DMTextField *)txtContactNo {
    if (!_txtContactNo) {
        _txtContactNo = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtLastName) + 10, WIDTH(self) - 20, 40) data:@"Contact No"];
        _txtContactNo.txtField.delegate = self;
        _txtContactNo.txtField.tag = 3;
    }
    return _txtContactNo;
}

- (DMTextField *)txtCity {
    if (!_txtCity) {
        _txtCity = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtContactNo) + 20, WIDTH(self) - 20, 40) data:@"City"];
        _txtCity.txtField.delegate = self;
        _txtCity.txtField.tag = 4;
    }
    return _txtCity;
}

- (DMTextField *)txtState {
    if (!_txtState) {
        _txtState = [[DMTextField alloc] initWithFrame:CGRectMake(10, MaxY(_txtCity) + 10, WIDTH(self) - 20, 40) data:@"State"];
        _txtState.txtField.delegate = self;
        _txtState.txtField.tag = 5;
    }
    return _txtState;
}


- (void)updateData{
    _txtEmailId.txtField.text = [AppDelegate sharedDelegate].strEmail;
    _txtFirstName.txtField.text = [AppDelegate sharedDelegate].strFirstName;
    _txtMiddleName.txtField.text = [AppDelegate sharedDelegate].strMiddleName;
    _txtLastName.txtField.text = [AppDelegate sharedDelegate].strLastName;
    _txtContactNo.txtField.text = [AppDelegate sharedDelegate].strContactNo;
    _txtCity.txtField.text = [AppDelegate sharedDelegate].strCity;
    _txtState.txtField.text = [AppDelegate sharedDelegate].strState;
}

#pragma mark Save button Click Event
- (void)didTappedActorBasicDetailSaveButton:(UIButton *)sender {
    NSLog(@"didTappedAboutSaveButton");
    
    if (_txtFirstName.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter First name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtFirstName.txtField becomeFirstResponder];
    }else if (_txtMiddleName.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter Middle name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtMiddleName.txtField becomeFirstResponder];
    }else if (_txtLastName.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter Last name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtLastName.txtField becomeFirstResponder];
    }else if (_txtContactNo.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter Contact number name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtContactNo.txtField becomeFirstResponder];
    }else if (_txtCity.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter City." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtCity.txtField becomeFirstResponder];
    }else if (_txtState.txtField.text.length == 0) {
        [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter State." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show ];
        [_txtState.txtField becomeFirstResponder];
    }else {
        NSMutableDictionary *datadic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedDelegate].strUserid,@"id",_txtFirstName.txtField.text, @"first_name",_txtMiddleName.txtField.text,@"middle_name",_txtLastName.txtField.text,@"last_name",_txtEmailId.txtField.text,@"email",_txtCity.txtField.text,@"city",_txtState.txtField.text,@"state",_txtContactNo.txtField.text,@"contact_no",nil];
        
        if ([self.delegate respondsToSelector:@selector(didTappedActorBasicDetailSaveButton:)]) {
            [self.delegate didTappedActorBasicDetailSaveButton:datadic];
        }
    }
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
    switch (textField.tag) {
        case 0: {
            _txtFirstName.hLine.backgroundColor = BaseColor;
        }
            break;
        case 1: {
            _txtMiddleName.hLine.backgroundColor = BaseColor;
        }
            break;
        case 2: {
            _txtLastName.hLine.backgroundColor = BaseColor;
        }
            break;
        case 3: {
            _txtContactNo.hLine.backgroundColor = BaseColor;
        }
            break;
        case 4: {
            _txtCity.hLine.backgroundColor = BaseColor;
        }
            break;
        case 5: {
            _txtState.hLine.backgroundColor = BaseColor;
        }
            break;
        
        default:
            break;
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.textColor = GrayColor;
    switch (textField.tag) {
        case 0: {
            _txtFirstName.hLine.backgroundColor = GrayColor;
        }
            break;
        case 1: {
            _txtMiddleName.hLine.backgroundColor = GrayColor;
        }
            break;
        case 2: {
            _txtLastName.hLine.backgroundColor = GrayColor;
        }
            break;
        case 3: {
            _txtContactNo.hLine.backgroundColor = GrayColor;
        }
            break;
        case 4: {
            _txtCity.hLine.backgroundColor = GrayColor;
        }
            break;
        case 5: {
            _txtState.hLine.backgroundColor = GrayColor;
        }
            break;
        default:
            break;
    }

    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 3) {
        NSUInteger length = [self getLength:textField.text];
        
        if(length == 10)    {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)    {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"%@ ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)    {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"%@-%@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@-%@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    return YES;
}

//Contact formate 111-222-3333
-(NSUInteger)getLength:(NSString*)mobileNumber     {
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSUInteger length = [mobileNumber length];
    
    return length;
}
//Contact formate 111-222-3333
-(NSString*)formatNumber:(NSString*)mobileNumber{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSUInteger length = [mobileNumber length];
    if(length > 10)         {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}

@end
