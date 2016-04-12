//
//  UpdateActorBioDetailView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "UpdateActorBioDetailView.h"

@implementation UpdateActorBioDetailView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        _first = @"";
        _second = @"";
        _pickerText = @"";
        [self addUIControl];
        self.aryFirstLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        self.arySecondLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return self;
}

- (void)addUIControl {
    [self addSubview:[self scrollView]];
    [[self scrollView] addSubview:[self ttlGender]];
    [[self scrollView] addSubview:[self chkMale]];
    [[self scrollView] addSubview:[self chkFemale]];
    [[self scrollView] addSubview:[self chkTransgender]];
    
    [[self scrollView] addSubview:[self ttlRace]];
    [[self scrollView] addSubview:[self txtRace]];
    
    [[self scrollView] addSubview:[self ttlAge]];
    [[self scrollView] addSubview:[self txtAgeRangeFrom]];
    [[self scrollView] addSubview:[self txtAgeRangeTo]];
    
    [[self scrollView] addSubview:[self ttlUnion]];
    [[self scrollView] addSubview:[self txtUnion]];
    
    [self setupKeyboardSettings];
    
    [self updateData];
    
    [[self scrollView] addSubview:[self btnSave]];
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
}

- (UIButton *)btnSave {
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(20, MaxY(_txtUnion) + 20, WIDTH(self) - 40, 50);
        [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSave addTarget:self action:@selector(didTappedBioDetailSaveButton:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[
                            _txtRace.txtField,
                            _txtAgeRangeFrom.txtField,
                            _txtAgeRangeTo.txtField,
                            _txtUnion.txtField];
    [_scrollView setContentSize:CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20)];
    //_scrollView.frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view) - 64 - 70);
    // _scrollView.contentSize =CGSizeMake(WIDTH(self.view), MaxY(_txtUnion) + 20);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
    }
    return _scrollView;
}

- (DMTitleView *)ttlGender {
    if (!_ttlGender) {
        _ttlGender = [[DMTitleView alloc] initWithFrame:CGRectMake(0, 10, WIDTH(self), 40) data:@"Choose gender"];
        _ttlGender.backgroundColor = TitleColor;
    }
    return _ttlGender;
}

- (DMCheckBox *)chkMale {
    if (!_chkMale) {
        _chkMale = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_ttlGender) + 10, WIDTH(self) - 40, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Male"}];
        _chkMale.tag = 0;
        [_chkMale addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkMale;
}

- (DMCheckBox *)chkFemale {
    if (!_chkFemale) {
        _chkFemale = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_chkMale) + 10, WIDTH(self) - 40, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"FeMale"}];
        _chkFemale.tag = 1;
        [_chkFemale addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkFemale;
}

- (DMCheckBox *)chkTransgender {
    if (!_chkTransgender) {
        _chkTransgender = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_chkFemale) + 10, WIDTH(self) - 40, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Transgender"}];
        _chkTransgender.tag = 2;
        [_chkTransgender addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTransgender;
}

#pragma mark Gender CheckBox
- (void)changedCheckBoxValue:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            _chkMale.img.image = [UIImage imageNamed:@"Check"];
            _chkFemale.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTransgender.img.image = [UIImage imageNamed:@"UnCheck"];
            _strGender = @"0";
        }
            break;
        case 1: {
            _chkMale.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkFemale.img.image = [UIImage imageNamed:@"Check"];
            _chkTransgender.img.image = [UIImage imageNamed:@"UnCheck"];
            _strGender = @"1";
        }
            break;
        default:{
            _chkMale.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkFemale.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTransgender.img.image = [UIImage imageNamed:@"Check"];
            _strGender = @"2";
        }
            break;
    }
}

- (DMTitleView *)ttlRace {
    if (!_ttlRace) {
        _ttlRace = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_chkTransgender) + 20, WIDTH(self), 40) data:@"Select Race"];
        _ttlRace.backgroundColor = TitleColor;
    }
    return _ttlRace;
}

- (DMTextField *)txtRace {
    if (!_txtRace) {
        _txtRace = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlRace) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Race",@"Name":@"Select Race"}];
        _txtRace.txtField.delegate = self;
        _txtRace.txtField.tag = 5;
        _txtRace.txtField.inputAccessoryView  = [self toolBar];
        _txtRace.txtField.inputView = [self pickerData];
    }
    return _txtRace;
}

- (DMTitleView *)ttlAge {
    if (!_ttlAge) {
        _ttlAge = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtRace) + 10, WIDTH(self), 40) data:@"Select Age Rang (to play)"];
        _ttlAge.backgroundColor = TitleColor;
    }
    return _ttlAge;
}

- (DMTextField *)txtAgeRangeFrom {
    if (!_txtAgeRangeFrom) {
        _txtAgeRangeFrom = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlAge) + 10, (WIDTH(self) - 20) / 2 - 10, 70) data:@{@"Icon":@"Age",@"Name":@"From"}];
        _txtAgeRangeFrom.txtField.delegate = self;
        _txtAgeRangeFrom.txtField.tag = 9;
        _txtAgeRangeFrom.txtField.inputAccessoryView  = [self toolBar];
        _txtAgeRangeFrom.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtAgeRangeFrom;
}

- (DMTextField *)txtAgeRangeTo {
    if (!_txtAgeRangeTo) {
        _txtAgeRangeTo = [[DMTextField alloc] initWithFrameTapButton:CGRectMake((WIDTH(self) - 20) / 2 + 10, MaxY(_ttlAge) + 10, (WIDTH(self) - 20) / 2, 70) data:@{@"Icon":@"Age",@"Name":@"To"}];
        _txtAgeRangeTo.txtField.delegate = self;
        _txtAgeRangeTo.txtField.tag = 10;
        _txtAgeRangeTo.txtField.inputAccessoryView  = [self toolBar];
        _txtAgeRangeTo.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtAgeRangeTo;
}

//- (TTRangeSlider *)ageSlider {
//    if (!_ageSlider) {
//        _ageSlider = [[TTRangeSlider alloc] initWithFrame:CGRectMake(10, MaxY(_ttlAge) + 10, WIDTH(self) - 20, 40)];
//        self.ageSlider.delegate = self;
//        self.ageSlider.minValue = 0;
//        self.ageSlider.maxValue = 100;
//        self.ageSlider.selectedMinimum = 18;
//        self.ageSlider.selectedMaximum = 90;
//        self.ageSlider.minLabelColour = BaseColor;
//        self.ageSlider.maxLabelColour = BaseColor;
//        self.ageSlider.tintColor = BaseColor;
//    }
//    return _ageSlider;
//}
//
//#pragma mark TTRangeSliderViewDelegate
//-(void)rangeSlider:(TTRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum{
//    if (sender == self.ageSlider){
//        NSLog(@"Standard slider updated. Min Value: %.0f Max Value: %.0f", selectedMinimum, selectedMaximum);
//    }
//}

- (DMTitleView *)ttlUnion {
    if (!_ttlUnion) {
        _ttlUnion = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtAgeRangeFrom) + 10, WIDTH(self), 40) data:@"Select Union Status"];
        _ttlUnion.backgroundColor = TitleColor;
    }
    return _ttlUnion;
}

- (DMTextField *)txtUnion {
    if (!_txtUnion) {
        _txtUnion = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlUnion) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Union Status",@"Name":@"Union"}];;
        _txtUnion.txtField.delegate = self;
        _txtUnion.txtField.tag = 8;
        _txtUnion.txtField.inputAccessoryView  = [self toolBar];
        _txtUnion.txtField.inputView = [self pickerData];
    }
    return _txtUnion;
}

#pragma mark UIPickerView
- (UIPickerView *)pickerData {
    _pickerData = [[UIPickerView alloc] init];
    _pickerData.dataSource = self;
    _pickerData.tag = 1;
    _pickerData.delegate = self;
    _pickerData.backgroundColor = [UIColor whiteColor];
    return _pickerData;
}

#pragma mark UIPickerView with multiple column
- (UIPickerView *)pickerDataMultiPleColumn {
    _pickerDataMultiPleColumn = [[UIPickerView alloc] init];
    _pickerDataMultiPleColumn.tag = 2;
    _pickerDataMultiPleColumn.dataSource = self;
    _pickerDataMultiPleColumn.delegate = self;
    _pickerDataMultiPleColumn.backgroundColor = [UIColor whiteColor];
    return _pickerDataMultiPleColumn;
}

#pragma mark UIToolbar
- (UIToolbar *)toolBar {
    _toolBar = [[UIToolbar alloc]init];
    _toolBar.barStyle = UIBarStyleDefault;
    _toolBar.translucent = true;
    _toolBar.tintColor = BaseColor;
    [_toolBar sizeToFit];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(clikcToolBarButton:)];
    cancel.tag = 0;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(clikcToolBarButton:)];
    done.tag = 1;
    
    [_toolBar setItems:@[cancel,flexSpace,done] animated:true];
    
    return _toolBar;
}

- (void)clikcToolBarButton:(UIBarButtonItem *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 0) {
        _pickerText = @"";
    }
    [_txtRace.txtField resignFirstResponder];
    [_txtUnion.txtField resignFirstResponder];
    [_txtAgeRangeFrom.txtField resignFirstResponder];
    [_txtAgeRangeTo.txtField resignFirstResponder];
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
    switch (textField.tag) {
        case 5: {
            _aryData = @[@"",@"African",@"African American",@"American Indian",@"Asian",@"Caucasian",@"East Indian",@"Eastern European",@"Filipino",@"Hispanic",@"Mediterranean",@"Middle Eastern",@"Mixed",@"Pacific Islander",@"West Indies/Caribbean"].mutableCopy;
            _txtRace.hLine.backgroundColor = BaseColor;
            break;
        }
       
        case 8: {
            _aryData = @[@"",@"Non Union",@"SAG Eligible",@"SAG",@"SAG-AFTRA",@"SAG-AFTRA Eligible"].mutableCopy;
            _txtUnion.hLine.backgroundColor = BaseColor;
            break;
        }
        default:
            break;
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.textColor = GrayColor;
    
    _txtRace.hLine.backgroundColor = GrayColor;
    _txtUnion.hLine.backgroundColor = GrayColor;
    
    NSLog(@"_pickerText = %@",_pickerText);
    
    switch (textField.tag) {
        case 5: {
            if (_pickerText.length>0) {
            _txtRace.txtField.text = _pickerText;
            }
            break;
        }
        case 8: {
            if (_pickerText.length>0) {
            _txtUnion.txtField.text = _pickerText;
            }
            break;
        }
        case 9: {
            if (_pickerText.length>0) {
                _txtAgeRangeFrom.txtField.text = _pickerText;
            }
            break;
        }
        case 10: {
            if (_pickerText.length>0) {
                _txtAgeRangeTo.txtField.text = _pickerText;
            }
            break;
        }
        default:
            break;
    }
    _pickerText = @"";
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}
#pragma mark UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 1) {
        return 1;
    }else if (pickerView.tag == 2) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return _aryData.count;
    }else if (pickerView.tag == 2) {
        return _aryFirstLetter.count;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (pickerView.tag == 2) {
        return 50;
    }else
        return WIDTH(self);
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    if (pickerView.tag == 1) {
        return _aryData[row];
        
    }else if (pickerView.tag == 2) {
        if(component == 0)
            return [self.aryFirstLetter objectAtIndex:row];
        else
            return [self.arySecondLetter objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
    if (pickerView.tag == 1) {
        _pickerText = _aryData[row];
    }else if (pickerView.tag == 2) {
        _pickerText = @"";
        if (component == 0) {
            _first = _aryFirstLetter[row];
            NSLog(@"first = %@",_aryFirstLetter[row]);
        }else if (component == 1)
            _second = _arySecondLetter[row];
            NSLog(@"second = %@",_arySecondLetter[row]);
        NSLog(@"%@%@",_aryFirstLetter[row],_arySecondLetter[row]);
        _pickerText = [NSString stringWithFormat:@"%@%@",_first,_second];
    
        _pickerText = [[@"" stringByAppendingString:_first]stringByAppendingString: _second];
    }
}

- (void)updateData{
    
    _txtRace.txtField.text = [AppDelegate sharedDelegate].strRace;
    _txtAgeRangeFrom.txtField.text = [AppDelegate sharedDelegate].strAgeFrom;
    _txtAgeRangeTo.txtField.text = [AppDelegate sharedDelegate].strAgeTo;
    _txtUnion.txtField.text = [AppDelegate sharedDelegate].strUnionStatus;
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"0"]) {
        _strGender = @"0";
        _chkMale.img.image = [UIImage imageNamed:CheckImage];
    }else if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
        _chkFemale.img.image = [UIImage imageNamed:CheckImage];
        _strGender = @"1";
    }
    else if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"2"]){
        _chkTransgender.img.image = [UIImage imageNamed:CheckImage];
        _strGender = @"2";
    }
    
}

#pragma mark Button Event
- (void)didTappedBioDetailSaveButton:(UIButton *)sender {
    NSLog(@"didTappedAboutSaveButton");
    
    
    NSMutableDictionary *datadic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedDelegate].strUserid,@"id",_strGender,@"gender",@"0000-00-00", @"birthdate",_txtAgeRangeFrom.txtField.text,@"agerange_from",_txtAgeRangeTo.txtField.text,@"agerange_to",_txtRace.txtField.text,@"race",_txtUnion.txtField.text,@"union_status",nil];
    
    NSLog(@"23243datadic = %@",datadic);
    
    if ([self.delegate respondsToSelector:@selector(didTappedActorBioDetailSaveButton:)]) {
        [self.delegate didTappedActorBioDetailSaveButton:datadic];
    }
}

@end
