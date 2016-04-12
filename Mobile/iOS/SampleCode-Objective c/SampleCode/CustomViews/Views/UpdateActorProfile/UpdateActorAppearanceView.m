//
//  UpdateActorAppearanceView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "UpdateActorAppearanceView.h"

@implementation UpdateActorAppearanceView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _first = @"";
        _second = @"";
        _third = @"";
        _pickerText = @"";
        //self.aryWeightFirstLetter = @[@"",@"0",@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2", @"3"];
        self.aryWeightFirstLetter = @[@"",@"0",@"1",@"2",@"3"];
        self.aryFirstLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        self.arySecondLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        self.aryThirdLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        [self addUIControl];
        NSLog(@"_aryWeightFirstLetter.count = %lu",(unsigned long)_aryWeightFirstLetter.count);
    }
    return self;
}

- (void)addUIControl {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateActorAppearanceFrame) name:@"UpdateAppearanceFrame" object:nil];
    
    NSLog(@"addUIControladdUIControl");
    [self addSubview:[self scrollView]];
    [[self scrollView] addSubview:[self ttlHeight]];
    [[self scrollView] addSubview:[self txtHeightFeet]];
    [[self scrollView] addSubview:[self txtHeightInches]];
    
    [_scrollView addSubview:[self ttlWeight]];
    [_scrollView addSubview:[self txtWeight]];
    //[[self scrollView] addSubview:[self sliderWeight]];
    
    [_scrollView addSubview:[self ttlHairColor]];
    [_scrollView addSubview:[self txtHairColor]];
    
    [_scrollView addSubview:[self ttlHairLength]];
    [_scrollView addSubview:[self txtHairLength]];
    
    [_scrollView addSubview:[self ttlEyeColor]];
    [_scrollView addSubview:[self txtEyeColor]];
    
    [_scrollView addSubview:[self ttlBodyType]];
    [_scrollView addSubview:[self txtBodyType]];
    
    [_scrollView addSubview:[self ttlCupSize]];
    [_scrollView addSubview:[self txtCupSize]];
    [_scrollView addSubview:[self ttlBustSize]];
    [_scrollView addSubview:[self txtBustSize]];
    
    [_scrollView addSubview:[self ttlFacial]];
    
    [_scrollView addSubview:[self lblFacialHair]];
    [_scrollView addSubview:[self chkFacialHairYes]];
    [_scrollView addSubview:[self chkFacialHairNo]];
    
    [_scrollView addSubview:[self lblBodyHair]];
    
    [_scrollView addSubview:[self chkBodyHairYes]];
    
    [_scrollView addSubview:[self chkBodyHairNo]];
    
    [_scrollView addSubview:[self lblTatoo]];
    
    [_scrollView addSubview:[self chkTatooYes]];
    [_scrollView addSubview:[self chkTatooNo]];
    [_scrollView addSubview:[self lblTatooVisible]];
    [_scrollView addSubview:[self chkTatooVisibleYes]];
    [_scrollView addSubview:[self chkTatooVisibleNo]];
    [_scrollView addSubview:[self lblPiercing]];
    
    [_scrollView addSubview:[self chkPiercingYes]];
    
    [_scrollView addSubview:[self chkPiercingNo]];
    
     [self updateActorAppearanceFrame];

    [_scrollView addSubview:[self lblPiercingVisible]];
    
    [_scrollView addSubview:[self chkPiercingVisibleYes]];
    
    [_scrollView addSubview:[self chkPiercingVisibleNo]];
    
    [_scrollView addSubview:[self txtHatSize]];
    
    [_scrollView addSubview:[self txtGloveSize]];
    
    [_scrollView addSubview:[self txtShoeSize]];
    
    [[self scrollView] addSubview:[self txtWaistSize]];
    
    [_scrollView addSubview:[self txtShirtSize]];
    
    [_scrollView addSubview:[self txtCoatSize]];
    
    [[self scrollView] addSubview:[self txtChestSize]];
    
    [self updateActorAppearanceFrame];
    
    [_scrollView addSubview:[self txtInSeam]];
    
    [_scrollView addSubview:[self txtGlasses]];
    
    [_scrollView addSubview:[self txtSpecialCharacteristic]];
    
    [_scrollView addSubview:[self txtAssistiveDevices]];
    
    [_scrollView addSubview:[self btnSave]];
    
    [self setupKeyboardSettings];
    
    [self updateData];
    
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
}

- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[_txtHeightFeet.txtField,
                            _txtHeightInches.txtField,
                            _txtWeight.txtField,
                            _txtHairColor.txtField,
                            _txtHairLength.txtField,
                            _txtEyeColor.txtField,
                            _txtBodyType.txtField,
                            _txtCupSize.txtField,
                            _txtBustSize.txtField,
                            _txtHatSize.txtField,
                            _txtGloveSize.txtField,
                            _txtShoeSize.txtField,
                            _txtWaistSize.txtField,
                            _txtShirtSize.txtField,
                            _txtCoatSize.txtField,
                            _txtChestSize.txtField,
                            _txtInSeam.txtField,
                            _txtGlasses.txtField,
                            _txtSpecialCharacteristic.txtField,
                            _txtAssistiveDevices.txtField];
    [_scrollView setContentSize:CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20)];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
    }
    return _scrollView;
}

- (UIButton *)btnSave {
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(20, MaxY(_txtAssistiveDevices) + 20, WIDTH(self) - 40, 50);
        [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSave addTarget:self action:@selector(didTappedAppearanceSaveButton:) forControlEvents:UIControlEventTouchUpInside];
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

- (DMTitleView *)ttlHeight {
    if (!_ttlHeight) {
        _ttlHeight = [[DMTitleView alloc] initWithFrame:CGRectMake(0, 10, WIDTH(self), 40) data:@"Select Your Height"];
        _ttlHeight.backgroundColor = TitleColor;
    }
    return _ttlHeight;
}

- (DMTextField *)txtHeightFeet {
    if (!_txtHeightFeet) {
        _txtHeightFeet = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlHeight) + 10, (WIDTH(self) - 20) / 2 - 10, 70) data:@{@"Icon":@"Height",@"Name":@"Feet"}];
        _txtHeightFeet.txtField.delegate = self;
        _txtHeightFeet.txtField.tag = 1;
        _txtHeightFeet.txtField.inputAccessoryView  = [self toolBar];
        _txtHeightFeet.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtHeightFeet;
}

- (DMTextField *)txtHeightInches {
    if (!_txtHeightInches) {
        _txtHeightInches = [[DMTextField alloc] initWithFrameTapButton:CGRectMake((WIDTH(self) - 20) / 2 + 10, MaxY(_ttlHeight) + 10, (WIDTH(self) - 20) / 2, 70) data:@{@"Icon":@"Height",@"Name":@"Inches"}];
        _txtHeightInches.txtField.delegate = self;
        _txtHeightInches.txtField.tag = 2;
        _txtHeightInches.txtField.inputAccessoryView  = [self toolBar];
        _txtHeightInches.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtHeightInches;
}

- (DMTitleView *)ttlWeight {
    if (!_ttlWeight) {
        _ttlWeight = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtHeightInches) + 20, WIDTH(self), 40) data:@"Select Your Weight"];
        _ttlWeight.backgroundColor = TitleColor;
    }
    return _ttlWeight;
}

- (DMTextField *)txtWeight {
    if (!_txtWeight) {
        _txtWeight = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlWeight) + 10, WIDTH(self) - 20 - 10, 70) data:@{@"Icon":@"Weight",@"Name":@"Weight"}];
        _txtWeight.txtField.delegate = self;
        _txtWeight.txtField.tag = 3;
        _txtWeight.txtField.inputAccessoryView  = [self toolBar];
        _txtWeight.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtWeight;
}

- (DMTitleView *)ttlHairColor {
    if (!_ttlHairColor) {
        _ttlHairColor = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtWeight) + 20, WIDTH(self), 40) data:@"Select Your hair color?"];
        _ttlHairColor.backgroundColor = TitleColor;
    }
    return _ttlHairColor;
}

- (DMTextField *)txtHairColor {
    if (!_txtHairColor) {
        _txtHairColor = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlHairColor) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Hair Color",@"Name":@"Hair Color"}];
        _txtHairColor.txtField.delegate = self;
        _txtHairColor.txtField.tag = 4;
        _txtHairColor.txtField.inputAccessoryView  = [self toolBar];
        _txtHairColor.txtField.inputView = [self pickerData];
    }
    return _txtHairColor;
}

- (DMTitleView *)ttlHairLength {
    if (!_ttlHairLength) {
        _ttlHairLength = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtHairColor) + 20, WIDTH(self), 40) data:@"Select Your hair Lenght / Style?"];
        _ttlHairLength.backgroundColor = TitleColor;
    }
    return _ttlHairLength;
}

- (DMTextField *)txtHairLength {
    if (!_txtHairLength) {
        _txtHairLength = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlHairLength) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Hair Style",@"Name":@"Hair Legnth / Style"}];
        _txtHairLength.txtField.delegate = self;
        _txtHairLength.txtField.tag = 5;
        _txtHairLength.txtField.inputAccessoryView  = [self toolBar];
        _txtHairLength.txtField.inputView = [self pickerData];
    }
    return _txtHairLength;
}
- (DMTitleView *)ttlEyeColor {
    if (!_ttlEyeColor) {
        _ttlEyeColor = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtHairLength) + 20, WIDTH(self), 40) data:@"Select Your Eye color?"];
        _ttlEyeColor.backgroundColor = TitleColor;
    }
    return _ttlEyeColor;
}

- (DMTextField *)txtEyeColor {
    if (!_txtEyeColor) {
        _txtEyeColor = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlEyeColor) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Eye Color",@"Name":@"Eye color"}];
        _txtEyeColor.txtField.delegate = self;
        _txtEyeColor.txtField.tag = 6;
        _txtEyeColor.txtField.inputAccessoryView  = [self toolBar];
        _txtEyeColor.txtField.inputView = [self pickerData];
    }
    return _txtEyeColor;
}

- (DMTitleView *)ttlBodyType {
    if (!_ttlBodyType) {
        _ttlBodyType = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtEyeColor) + 20, WIDTH(self), 40) data:@"Select Your Body Type?"];
        _ttlBodyType.backgroundColor = TitleColor;
    }
    return _ttlBodyType;
}

- (DMTextField *)txtBodyType {
    if (!_txtBodyType) {
        _txtBodyType = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlBodyType) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Body Type",@"Name":@"Body Type"}];
        _txtBodyType.txtField.delegate = self;
        _txtBodyType.txtField.tag = 7;
        _txtBodyType.txtField.inputAccessoryView  = [self toolBar];
        _txtBodyType.txtField.inputView = [self pickerData];
    }
    return _txtBodyType;
}

- (DMTitleView *)ttlCupSize {
    if (!_ttlCupSize) {
        _ttlCupSize = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtBodyType) + 20, WIDTH(self), 40) data:@"Select Your Cup Size"];
        _ttlCupSize.backgroundColor = TitleColor;
        _ttlCupSize.hidden = true;
    }
    return _ttlCupSize;
}

- (DMTextField *)txtCupSize {
    if (!_txtCupSize) {
        _txtCupSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlCupSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Cup",@"Name":@"Cup Size"}];
        _txtCupSize.txtField.delegate = self;
        _txtCupSize.txtField.tag = 8;
        _txtCupSize.txtField.inputAccessoryView  = [self toolBar];
        _txtCupSize.txtField.inputView = [self pickerData];
        _txtCupSize.hidden = true;
    }
    return _txtCupSize;
}

- (DMTitleView *)ttlBustSize {
    if (!_ttlBustSize) {
        _ttlBustSize = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtCupSize) + 20, WIDTH(self), 40) data:@"Select Your Bust Size"];
        _ttlBustSize.backgroundColor = TitleColor;
        _ttlBustSize.hidden = true;
    }
    return _ttlBustSize;
}

- (DMTextField *)txtBustSize {
    if (!_txtBustSize) {
        _txtBustSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlBustSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Bust",@"Name":@"Bust Size"}];
        _txtBustSize.txtField.delegate = self;
        _txtBustSize.txtField.tag = 9;
        _txtBustSize.txtField.inputAccessoryView  = [self toolBar];
        _txtBustSize.txtField.inputView = [self pickerData];
        _txtBustSize.hidden = true;
    }
    return _txtBustSize;
}

- (DMTitleView *)ttlFacial {
    if (!_ttlFacial) {
        if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
            _ttlFacial = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtBustSize) + 20, WIDTH(self), 40) data:@"Choose any of the following"];
            [self visibility];
        }else{
            _ttlFacial = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtBodyType) + 20, WIDTH(self), 40) data:@"Choose any of the following"];
        }
        _ttlFacial.lblTitle.numberOfLines = 2.0f;
        _ttlFacial.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlFacial.backgroundColor = TitleColor;
    }
    return _ttlFacial;
}

- (DMLabel *)lblFacialHair {
    if (!_lblFacialHair) {
        _lblFacialHair = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_ttlFacial) + 10, WIDTH(self), 20) data:@{@"Icon":@"Facial Hair",@"Name":@"Facial Hair"}];
        _lblFacialHair.hidden = true;
    }
    return _lblFacialHair;
}

- (DMCheckBox *)chkFacialHairYes {
    if (!_chkFacialHairYes) {
        _chkFacialHairYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblFacialHair) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkFacialHairYes.hidden = true;
        _chkFacialHairYes.tag = 0;
        [_chkFacialHairYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkFacialHairYes;
}

- (DMCheckBox *)chkFacialHairNo {
    if (!_chkFacialHairNo) {
        _chkFacialHairNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkFacialHairYes), MaxY(_lblFacialHair) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkFacialHairNo.tag = 1;
        [_chkFacialHairNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
        _chkFacialHairNo.hidden = true;
    }
    return _chkFacialHairNo;
}

- (DMLabel *)lblBodyHair {
    if (!_lblBodyHair) {
        _lblBodyHair = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_chkFacialHairNo) + 20, WIDTH(self), 20) data:@{@"Icon":@"Body Hair",@"Name":@"Body Hair"}];
        _lblBodyHair.hidden = true;
    }
    return _lblBodyHair;
}

- (DMCheckBox *)chkBodyHairYes {
    if (!_chkBodyHairYes) {
        _chkBodyHairYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblBodyHair) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkBodyHairYes.tag = 2;
        [_chkBodyHairYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
        _chkBodyHairYes.hidden = true;
    }
    return _chkBodyHairYes;
}

- (DMCheckBox *)chkBodyHairNo {
    if (!_chkBodyHairNo) {
        _chkBodyHairNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkBodyHairYes), MaxY(_lblBodyHair) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkBodyHairNo.tag = 3;
        [_chkBodyHairNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
        _chkBodyHairNo.hidden = true;
    }
    return _chkBodyHairNo;
}

- (DMLabel *)lblTatoo {
    if (!_lblTatoo) {
        if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
             _lblTatoo = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_ttlFacial) + 20, WIDTH(self), 20) data:@{@"Icon":@"Tattos",@"Name":@"Tatoo"}];
            [self visibility];
        }else
            _lblTatoo = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_chkBodyHairNo) + 20, WIDTH(self), 20) data:@{@"Icon":@"Tattos",@"Name":@"Tatoo"}];
        [self visibility];
    }
    return _lblTatoo;
}

- (DMCheckBox *)chkTatooYes {
    if (!_chkTatooYes) {
        _chkTatooYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblTatoo) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkTatooYes.tag = 4;
        [_chkTatooYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTatooYes;
}

- (DMCheckBox *)chkTatooNo {
    if (!_chkTatooNo) {
        _chkTatooNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkTatooYes), MaxY(_lblTatoo) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkTatooNo.tag = 5;
        [_chkTatooNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTatooNo;
}

- (DMLabel *)lblTatooVisible {
    if (!_lblTatooVisible) {
        _lblTatooVisible = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_chkTatooNo) + 20, WIDTH(self), 20) data:@{@"Icon":@"Tattos Invisible",@"Name":@"Tatoo Visible"}];
    }
    return _lblTatooVisible;
}

- (DMCheckBox *)chkTatooVisibleYes {
    if (!_chkTatooVisibleYes) {
        _chkTatooVisibleYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblTatooVisible) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkTatooVisibleYes.tag = 6;
        [_chkTatooVisibleYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTatooVisibleYes;
}

- (DMCheckBox *)chkTatooVisibleNo {
    if (!_chkTatooVisibleNo) {
        _chkTatooVisibleNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkTatooVisibleYes), MaxY(_lblTatooVisible) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkTatooVisibleNo.tag = 7;
        [_chkTatooVisibleNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTatooVisibleNo;
}


- (DMLabel *)lblPiercing {
    if (!_lblPiercing) {
        _lblPiercing = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_chkTatooVisibleNo) + 20, WIDTH(self), 20) data:@{@"Icon":@"Piercing",@"Name":@"Piercing"}];
    }
    return _lblPiercing;
}

- (DMCheckBox *)chkPiercingYes {
    if (!_chkPiercingYes) {
        _chkPiercingYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblPiercing) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkPiercingYes.tag = 8;
        [_chkPiercingYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPiercingYes;
}

- (DMCheckBox *)chkPiercingNo {
    if (!_chkPiercingNo) {
        _chkPiercingNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkPiercingYes), MaxY(_lblPiercing) + 20, (WIDTH(self) - 20) /2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkPiercingNo.tag = 9;
        [_chkPiercingNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPiercingNo;
}

- (DMLabel *)lblPiercingVisible {
    if (!_lblPiercingVisible) {
        _lblPiercingVisible = [[DMLabel alloc] initWithFrameIconLabel:CGRectMake(10, MaxY(_chkPiercingNo) + 20, WIDTH(self), 20) data:@{@"Icon":@"Piercing Invisible",@"Name":@"Piercing Visible"}];
    }
    return _lblPiercingVisible;
}

- (DMCheckBox *)chkPiercingVisibleYes {
    if (!_chkPiercingVisibleYes) {
        _chkPiercingVisibleYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(20, MaxY(_lblPiercingVisible) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkPiercingVisibleYes.tag = 10;
        [_chkPiercingVisibleYes addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPiercingVisibleYes;
}

- (DMCheckBox *)chkPiercingVisibleNo {
    if (!_chkPiercingVisibleNo) {
        _chkPiercingVisibleNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkPiercingVisibleYes), MaxY(_lblPiercingVisible) + 20, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkPiercingVisibleNo.tag = 11;
        [_chkPiercingVisibleNo addTarget:self action:@selector(changedFacialCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPiercingVisibleNo;
}

- (DMTextField *)txtHatSize {
    if (!_txtHatSize) {
        _txtHatSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_chkPiercingVisibleNo) + 20, WIDTH(self) - 20, 70) data:@{@"Icon":@"Hat", @"Name":@"Hat Size"}];
        _txtHatSize.txtField.delegate = self;
        _txtHatSize.txtField.tag = 10;
        _txtHatSize.txtField.inputAccessoryView  = [self toolBar];
        _txtHatSize.txtField.inputView = [self pickerData];
    }
    return _txtHatSize;
}

- (DMTextField *)txtGloveSize {
    if (!_txtGloveSize) {
        _txtGloveSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtHatSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Glove", @"Name":@"Glove Size"}];
        _txtGloveSize.txtField.delegate = self;
        _txtGloveSize.txtField.tag = 11;
        _txtGloveSize.txtField.inputAccessoryView  = [self toolBar];
        _txtGloveSize.txtField.inputView = [self pickerData];
    }
    return _txtGloveSize;
}

- (DMTextField *)txtShoeSize {
    if (!_txtShoeSize) {
        _txtShoeSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtGloveSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Shoe",@"Name":@"Shoe Size"}];
        _txtShoeSize.txtField.delegate = self;
        _txtShoeSize.txtField.tag = 12;
        _txtShoeSize.txtField.inputAccessoryView  = [self toolBar];
        _txtShoeSize.txtField.inputView = [self pickerData];
    }
    return _txtShoeSize;
}

- (DMTextField *)txtWaistSize {
    if (!_txtWaistSize) {
        _txtWaistSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtShoeSize) + 10, WIDTH(self) - 20 - 10, 70) data:@{@"Icon":@"Height",@"Name":@"Waist size"}];
        _txtWaistSize.txtField.delegate = self;
        _txtWaistSize.txtField.tag = 13;
        _txtWaistSize.txtField.inputAccessoryView  = [self toolBar];
        _txtWaistSize.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtWaistSize;
}

- (DMTextField *)txtShirtSize {
    if (!_txtShirtSize) {
        _txtShirtSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtWaistSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Shirt",@"Name":@"Shirt Size"}];
        _txtShirtSize.txtField.delegate = self;
        _txtShirtSize.txtField.tag = 14;
        _txtShirtSize.txtField.inputAccessoryView  = [self toolBar];
        _txtShirtSize.txtField.inputView = [self pickerData];
    }
    return _txtShirtSize;
}

- (DMTextField *)txtCoatSize {
    if (!_txtCoatSize) {
        _txtCoatSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtShirtSize) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Coat",@"Name":@"Coat Size"}];
        _txtCoatSize.txtField.delegate = self;
        _txtCoatSize.txtField.tag = 15;
        _txtCoatSize.txtField.inputAccessoryView  = [self toolBar];
        _txtCoatSize.txtField.inputView = [self pickerData];
    }
    return _txtCoatSize;
}

- (DMTextField *)txtChestSize {
    if (!_txtChestSize) {
        _txtChestSize = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtCoatSize) + 20, WIDTH(self) - 20 - 10, 70) data:@{@"Icon":@"Height",@"Name":@"Chest size"}];
        _txtChestSize.txtField.delegate = self;
        _txtChestSize.txtField.tag = 16;
        _txtChestSize.txtField.inputAccessoryView  = [self toolBar];
        _txtChestSize.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtChestSize;
}

- (DMTextField *)txtInSeam {
    if (!_txtInSeam) {
        _txtInSeam = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtChestSize) + 20, WIDTH(self) - 20, 70) data:@{@"Icon":@"In Seam",@"Name":@"In Seam"}];
        _txtInSeam.txtField.delegate = self;
        _txtInSeam.txtField.tag = 17;
        _txtInSeam.txtField.inputAccessoryView  = [self toolBar];
        _txtInSeam.txtField.inputView = [self pickerData];
    }
    return _txtInSeam;
}

- (DMTextField *)txtGlasses {
    if (!_txtGlasses) {
        _txtGlasses = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtInSeam) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Glasses",@"Name":@"Glasses Or Contacts"}];
        _txtGlasses.txtField.delegate = self;
        _txtGlasses.txtField.tag = 18;
        _txtGlasses.txtField.inputAccessoryView  = [self toolBar];
        _txtGlasses.txtField.inputView = [self pickerData];
    }
    return _txtGlasses;
}

- (DMTextField *)txtSpecialCharacteristic {
    if (!_txtSpecialCharacteristic) {
        _txtSpecialCharacteristic = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtGlasses) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Special Characteristic",@"Name":@"Special Characteristic"}];
        _txtSpecialCharacteristic.txtField.delegate = self;
        _txtSpecialCharacteristic.txtField.tag = 19;
        _txtSpecialCharacteristic.txtField.inputAccessoryView  = [self toolBar];
        _txtSpecialCharacteristic.txtField.inputView = [self pickerData];
    }
    return _txtSpecialCharacteristic;
}

- (DMTextField *)txtAssistiveDevices {
    if (!_txtAssistiveDevices) {
        _txtAssistiveDevices = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtSpecialCharacteristic) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Assistive Devices",@"Name":@"Special : Assistive Devices"}];
        _txtAssistiveDevices.txtField.delegate = self;
        _txtAssistiveDevices.txtField.tag = 20;
        _txtAssistiveDevices.txtField.inputAccessoryView  = [self toolBar];
        _txtAssistiveDevices.txtField.inputView = [self pickerData];
    }
    return _txtAssistiveDevices;
}

#pragma mark CheckBox Method
- (void)changedFacialCheckBoxValue:(DMCheckBox *)sender {
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    switch (sender.tag) {
        case 0:{
            _chkFacialHairYes.img.image = [UIImage imageNamed:@"Check"];
            _chkFacialHairNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strFacialHair = @"1";
        }
            break;
        case 1:{
            _chkFacialHairYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkFacialHairNo.img.image = [UIImage imageNamed:@"Check"];
            _strFacialHair = @"0";
        }
            break;
        case 2:{
            _chkBodyHairYes.img.image = [UIImage imageNamed:@"Check"];
            _chkBodyHairNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strBodyHair = @"1";
        }
            break;
        case 3:{
            _chkBodyHairYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkBodyHairNo.img.image = [UIImage imageNamed:@"Check"];
            _strBodyHair = @"0";
        }
            break;
        case 4:{
            _chkTatooYes.img.image = [UIImage imageNamed:@"Check"];
            _chkTatooNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strTatoo = @"1";
        }
            break;
        case 5:{
            _chkTatooYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTatooNo.img.image = [UIImage imageNamed:@"Check"];
            _strTatoo = @"0";
        }
            break;
        case 6:{
            _chkTatooVisibleYes.img.image = [UIImage imageNamed:@"Check"];
            _chkTatooVisibleNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strTatooVisible = @"1";
        }
            break;
        case 7:{
            _chkTatooVisibleYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTatooVisibleNo.img.image = [UIImage imageNamed:@"Check"];
            _strTatooVisible = @"0";
        }
            break;
        case 8:{
            _chkPiercingYes.img.image = [UIImage imageNamed:@"Check"];
            _chkPiercingNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strPiercing = @"1";
        }
            break;
        case 9:{
            _chkPiercingYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkPiercingNo.img.image = [UIImage imageNamed:@"Check"];
            _strPiercing = @"0";
        }
            break;
        case 10:{
            _chkPiercingVisibleYes.img.image = [UIImage imageNamed:@"Check"];
            _chkPiercingVisibleNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strPiercingVisible = @"1";
        }
            break;
        case 11:{
            _chkPiercingVisibleYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkPiercingVisibleNo.img.image = [UIImage imageNamed:@"Check"];
            _strPiercingVisible = @"0";
        }
            break;
        default:
            break;
    }
}


#pragma mark UIPickerView
- (UIPickerView *)pickerData {
    _pickerData = [[UIPickerView alloc] init];
    _pickerData.dataSource = self;
    _pickerData.delegate = self;
    _pickerData.tag = 1.0f;
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
        [self hideKeyboard];
    }else {
        [self hideKeyboard];
    }
}

- (void)hideKeyboard {
    [_txtHairColor.txtField resignFirstResponder];
    [_txtHairLength.txtField resignFirstResponder];
    [_txtEyeColor.txtField resignFirstResponder];
    [_txtBodyType.txtField resignFirstResponder];
    [_txtHatSize.txtField resignFirstResponder];
    [_txtGloveSize.txtField resignFirstResponder];
    [_txtShoeSize.txtField resignFirstResponder];
    [_txtShirtSize.txtField resignFirstResponder];
    [_txtCoatSize.txtField resignFirstResponder];
    [_txtInSeam.txtField resignFirstResponder];
    [_txtGlasses.txtField resignFirstResponder];
    [_txtSpecialCharacteristic.txtField resignFirstResponder];
    [_txtAssistiveDevices.txtField resignFirstResponder];
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
    _pickerComponent = 1;
    switch (textField.tag) {
        case 1: {
            //Feet
            _pickerComponent = 1;
        }
            break;
        case 2: {
            //Inches
            _pickerComponent = 2;
        }
            break;
        case 3: {
            _pickerComponent = 3;
            
        }
            break;
        case 4: {
            //Hair Color
            _aryData = @[@"",@"Auburn",@"Bald",@"Blonde", @"Brown", @"Honey", @"Brown",@"Black",@"Grey",@"Multi-Color",@"Red",@"Salt", @"Pepper", @"Silver", @"Strawberry", @"Blonde", @"White", @"N/A"].mutableCopy;
        }
            break;
        case 5: {
            //Hair Length / Style
            _aryData = @[@"",@"Afro",@"Bald",@"Bald on Top",@"Buzz Cut",@"Chin Length",@"Cornrows",@"Dreadlocks",@"Long",@"Mullet",@"Receding",@"Shaved",@"Short",@"Shoulder Length",@"Spiky",@"Undercut",@"N/A"].mutableCopy;
        }
            break;
        case 6: {
            //Eye Color
            _aryData = @[@"",@"Black",@"Blue",@"Brown",@"Green",@"Grey",@"Hazel",@"N/A"].mutableCopy;
        }
            break;
        case 7: {
            //BodyType
            _aryData = @[@"",@"Small Frame",@"Thin",@"Athletic",@"Average",@"Some Extra Pounds",@"Body Builder",@"XL",@"XXL",@"N/A"].mutableCopy;
        }
            break;
        case 8: {
            //Cup Size
            if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"2"])
                _aryData = @[@"",@"AA",@"A",@"B",@"C",@"D",@"DD",@"DDD+",@"N/A"].mutableCopy;
            else
                _aryData = @[@"",@"AA",@"A",@"B",@"C",@"D",@"DD",@"DDD+"].mutableCopy;
        }
            break;
        case 9: {
            //Bust Size
            if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"2"])
                _aryData = @[@"",@"28",@"30",@"32",@"34",@"36",@"38",@"40",@"42",@"44", @"46",@"48",@"50+",@"N/A"].mutableCopy;
            else
                _aryData = @[@"",@"28",@"30",@"32",@"34",@"36",@"38",@"40",@"42",@"44", @"46", @"48",@"50+"].mutableCopy;
        }
            break;
        case 10: {
            //HatSize
            _aryData = @[@"",@"6 and 7/8",@"7",@"7 and 1/8",@"7 and 1/4",@"7 and 3/8",@"7 and 1/2",@"7 and 5/8",@"7 and 3/4",@"N/A"].mutableCopy;
        }
            break;
        case 11: {
            //Glove Size
            _aryData = @[@"",@"XS",@"S",@"M",@"L",@"XL",@"XXL",@"N/A"].mutableCopy;
        }
            break;
        case 12: {
            //Shoe Size
            _aryData = @[@"",@"2",@"3.5",@"4",@"4.5",@"5",@"5.5",@" 6",@"6.5",@"7", @"7.5",@"8",@"8.5", @"9",@"9.5",@"10",@"10.5",@"11",@"11.5", @"12",@"13",@"14",@"15",@"16",@"17+",@"N/A"].mutableCopy;
        }
            break;
        case 13: {
            //Waist size
            _pickerComponent = 2;
        }
            break;
        case 14: {
            //Shirt size
            _aryData = @[@"",@"XXS",@"XS",@"S",@"M",@"L",@"XL",@"XXL",@"XXXL",@"N/A"].mutableCopy;
        }
            break;
        case 15: {
            //Coat size
            _aryData = @[@"",@"Short (S)",@"Regular (R)",@"Long (L)",@"X-Long (XL)",@"N/A"].mutableCopy;
        }
            break;
        case 16: {
            //Chest size
            _pickerComponent = 2;
        }
            break;
        case 17: {
            //InSeam
            _aryData = @[@"",@"26", @"26.5", @"27", @"27.5", @"28", @"28.5", @"29", @"29.5", @"30", @"30.5", @"31", @"31.5", @"32", @"32.5", @"33", @"33.5", @"N/A"].mutableCopy;
        }
            break;
        case 18: {
            //Glass contact
            _aryData = @[@"",@"Yes Glasses",@"Yes Contacts",@"None",@"Both",@"N/A"].mutableCopy;
        }
            break;
        case 19: {
            //Special Characteristic
            _aryData = @[@"Amputee Arm",@"Amputee Double",@"Amputee Leg",@"Amputee Single",@"Asperger's",@"Autism",@"Blind Or Low Vision",@"Cerebral Palsy",@"Deaf or Hard of Hearing",@"Down syndrome",@"Intellectual Disability",@"Little Person",@"Mobility Disability",@"Wheelchair User",@"N/A"].mutableCopy;
            SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
            multipleSelect.delegate = self;
            multipleSelect.tag = 1;
            multipleSelect.rowsCount = _aryData.count;
            [multipleSelect show];
            return false;
        }
            break;
        case 20: {
            //Special : Assitive Devices
            _aryData = @[@"Cane",@"Crutches: Forearm",@"Crutches: Underarm",@"Leg Braces",@"Mobility Scooter",@"Prosthetic Limb: Arm",@"Prosthetic Limb: Leg",@"Service Animal",@"Voice Box: Mechanical Larynx",@"Walker",@" Wheelchair: Manual",@"Wheelchair: Power",@"White Cane",@"N/A"].mutableCopy;
            SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
            multipleSelect.delegate = self;
            multipleSelect.tag = 2;
            multipleSelect.rowsCount = _aryData.count;
            [multipleSelect show];
            return false;
        }
            break;
        default:
            break;
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.textColor = GrayColor;
    NSLog(@"_pickerText = %@",_pickerText);
    if (_pickerText.length>0) {
        switch (textField.tag) {
            case 1:
                _txtHeightFeet.txtField.text = _pickerText;
                break;
            case 2:
                _txtHeightInches.txtField.text = _pickerText;
                break;
            case 3:
                _txtWeight.txtField.text = _pickerText;
                break;
            case 4:
                _txtHairColor.txtField.text = _pickerText;
                break;
            case 5:
                _txtHairLength.txtField.text = _pickerText;
                break;
            case 6:
                _txtEyeColor.txtField.text = _pickerText;
                break;
            case 7:
                _txtBodyType.txtField.text = _pickerText;
                break;
            case 8:
                _txtCupSize.txtField.text = _pickerText;
                break;
            case 9:
                _txtBustSize.txtField.text = _pickerText;
                break;
            case 10:
                _txtHatSize.txtField.text = _pickerText;
                break;
            case 11:
                _txtGloveSize.txtField.text = _pickerText;
                break;
            case 12:
                _txtShoeSize.txtField.text = _pickerText;
                break;
            case 13:
                _txtWaistSize.txtField.text = _pickerText;
                break;
            case 14:
                _txtShirtSize.txtField.text = _pickerText;
                break;
            case 15:
                _txtCoatSize.txtField.text = _pickerText;
                break;
            case 16:
                _txtChestSize.txtField.text = _pickerText;
                break;
            case 17:
                _txtInSeam.txtField.text = _pickerText;
                break;
            case 18:
                _txtGlasses.txtField.text = _pickerText;
                break;
            default:
                break;
        }
    }
    _pickerText = @"";
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark Tap To select Click Event
- (void)didTappedSelectClickEvent:(UIButton *)sender {
    NSLog(@"SenderTag = %ld",(long)sender.tag);
}

#pragma mark UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 1) {
        return _pickerComponent;
    }else if (pickerView.tag == 2) {
        return _pickerComponent;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return _aryData.count;
    }else if (pickerView.tag == 2) {
        if (_pickerComponent == 3) {
            if (component == 0) {
                return _aryWeightFirstLetter.count;
            }else
                return _aryFirstLetter.count;
        }else
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
        
    }else if (pickerView.tag == 2 && _pickerComponent == 3) {
        if(component == 0)
            return [self.aryWeightFirstLetter objectAtIndex:row];
        else if(component == 1)
            return [self.arySecondLetter objectAtIndex:row];
        else if (component == 2)
            return [self.aryThirdLetter objectAtIndex:row];
    }else if (pickerView.tag == 2){
        if(component == 0)
            return [self.aryFirstLetter objectAtIndex:row];
        else if(component == 1)
            return [self.arySecondLetter objectAtIndex:row];
        else if (component == 2)
            return [self.aryThirdLetter objectAtIndex:row];
    }
    return @"";
}
//LIT20
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    if (pickerView.tag == 1) {
        _pickerText = _aryData[row];
    }else if (pickerView.tag == 2 && _pickerComponent == 3) {
        _pickerText = @"";
        if (component == 0) {
            _first = _aryWeightFirstLetter[row];
        }else if (component == 1)
            _second = _arySecondLetter[row];
        else if (component == 2)
            _third = _aryThirdLetter[row];
        NSLog(@"f=%@, s=%@, t=%@",_first, _second, _third);
        NSLog(@"component = %ld",(long)component);
        if (_pickerComponent == 3) {
            _pickerText = [NSString stringWithFormat:@"%@%@%@",_first,_second,_third];
            _pickerText = [[[@"" stringByAppendingString:_first]stringByAppendingString: _second] stringByAppendingString:_third];
        }else if (_pickerComponent == 2) {
            _pickerText = [NSString stringWithFormat:@"%@%@",_first,_second];
            _pickerText = [[@"" stringByAppendingString:_first]stringByAppendingString: _second];
        }else{
            _pickerText = [NSString stringWithFormat:@"%@",_first];
            _pickerText = [@"" stringByAppendingString:_first];
        }
    }
    else if (pickerView.tag == 2) {
        _pickerText = @"";
        if (component == 0) {
            _first = _aryFirstLetter[row];
        }else if (component == 1)
            _second = _arySecondLetter[row];
        else if (component == 2)
            _third = _aryThirdLetter[row];
        
        if (_pickerComponent == 3) {
            _pickerText = [NSString stringWithFormat:@"%@%@%@",_first,_second,_third];
            _pickerText = [[[@"" stringByAppendingString:_first]stringByAppendingString: _second] stringByAppendingString:_third];
        }else if (_pickerComponent == 2){
            _pickerText = [NSString stringWithFormat:@"%@%@",_first,_second];
            _pickerText = [[@"" stringByAppendingString:_first]stringByAppendingString: _second];
        }else{
            _pickerText = _first;
        }
    }
}

- (void)updateData{
    _txtHeightFeet.txtField.text = [AppDelegate sharedDelegate].strHeightFeet;
    _txtHeightInches.txtField.text = [AppDelegate sharedDelegate].strheightInch;
    _txtWeight.txtField.text = [AppDelegate sharedDelegate].strWeight;
    _txtHairColor.txtField.text = [AppDelegate sharedDelegate].strHairColor;
    _txtHairLength.txtField.text = [AppDelegate sharedDelegate].strHairLength;
    _txtEyeColor.txtField.text = [AppDelegate sharedDelegate].strEyeColor;
    
    _txtBodyType.txtField.text = [AppDelegate sharedDelegate].strBodyType;
    _txtHatSize.txtField.text = [AppDelegate sharedDelegate].strHatSizem;
    _txtGloveSize.txtField.text = [AppDelegate sharedDelegate].strGloveSize;
    _txtShoeSize.txtField.text = [AppDelegate sharedDelegate].strShoeSize;
    _txtWaistSize.txtField.text = [AppDelegate sharedDelegate].strWaist;
    _txtShirtSize.txtField.text = [AppDelegate sharedDelegate].strShirtSize;
    
    _txtCoatSize.txtField.text = [AppDelegate sharedDelegate].strCoatSize;
    _txtChestSize.txtField.text = [AppDelegate sharedDelegate].strChestSizeFemale;
    _txtInSeam.txtField.text = [AppDelegate sharedDelegate].strInSteam;
    _txtGlasses.txtField.text = [AppDelegate sharedDelegate].strGlasses;
    _txtSpecialCharacteristic.txtField.text = [AppDelegate sharedDelegate].strDisability;
    _txtAssistiveDevices.txtField.text = [AppDelegate sharedDelegate].strDisabilityDevice;

    

    if ([[AppDelegate sharedDelegate].strTattoos isEqualToString:@"1"]) {
        _chkTatooYes.img.image = [UIImage imageNamed:CheckImage];
        _strTatoo = @"1";
    }else if ([[AppDelegate sharedDelegate].strTattoos isEqualToString:@"0"]){
        _strTatoo = @"0";
        _chkTatooNo.img.image = [UIImage imageNamed:CheckImage];
    }
    
    if ([[AppDelegate sharedDelegate].strTattoosVisible isEqualToString:@"1"]) {
        _chkTatooVisibleYes.img.image = [UIImage imageNamed:CheckImage];
        _strTatooVisible = @"1";
    }else if ([[AppDelegate sharedDelegate].strTattoosVisible isEqualToString:@"0"]){
        _chkTatooVisibleNo.img.image = [UIImage imageNamed:CheckImage];
        _strTatooVisible = @"0";
    }
    
    if ([[AppDelegate sharedDelegate].strPiercing isEqualToString:@"1"]) {
        _strPiercing = @"1";;
        _chkPiercingYes.img.image = [UIImage imageNamed:CheckImage];
    }else if ([[AppDelegate sharedDelegate].strPiercing isEqualToString:@"0"]){
        _chkPiercingNo.img.image = [UIImage imageNamed:CheckImage];
        _strPiercing = @"0";;
    }
    
    if ([[AppDelegate sharedDelegate].strPiercingVisible isEqualToString:@"1"]) {
        _strPiercingVisible = @"1";
        _chkPiercingVisibleYes.img.image = [UIImage imageNamed:CheckImage];
    }else if ([[AppDelegate sharedDelegate].strPiercingVisible isEqualToString:@"0"]){
        _chkPiercingVisibleNo.img.image = [UIImage imageNamed:CheckImage];
        _strPiercingVisible = @"0";
    }
    
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"2"]) {
        _txtCupSize.txtField.text = [AppDelegate sharedDelegate].strCupSize;
        _txtBustSize.txtField.text = [AppDelegate sharedDelegate].strBustSize;
    }else {
        if ([[AppDelegate sharedDelegate].strFacialHair isEqualToString:@"1"]) {
            _chkFacialHairYes.img.image = [UIImage imageNamed:CheckImage];
            _strFacialHair = @"1";
        }else if ([[AppDelegate sharedDelegate].strFacialHair isEqualToString:@"0"]){
            _chkFacialHairNo.img.image = [UIImage imageNamed:CheckImage];
            _strFacialHair = @"0";
        }
        
        if ([[AppDelegate sharedDelegate].strBosyHair isEqualToString:@"1"]) {
            _chkBodyHairYes.img.image = [UIImage imageNamed:CheckImage];
            _strBodyHair = @"1";
        }else if ([[AppDelegate sharedDelegate].strBosyHair isEqualToString:@"0"]){
            _chkBodyHairNo.img.image = [UIImage imageNamed:CheckImage];
            _strBodyHair = @"0";
        }
    }
}

- (void)visibility{
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
        _ttlCupSize.hidden = false;
        _txtCupSize.hidden = false;
        _ttlBustSize.hidden = false;
        _txtBustSize.hidden = false;
        
        _lblFacialHair.hidden = true;
        _chkFacialHairYes.hidden = true;
        _chkFacialHairNo.hidden = true;
        
        _lblBodyHair.hidden = true;
        _chkBodyHairYes.hidden = true;
        _chkBodyHairNo.hidden = true;
    }else{
        _ttlCupSize.hidden = true;
        _txtCupSize.hidden = true;
        _ttlBustSize.hidden = true;
        _txtBustSize.hidden = true;
        
        _lblFacialHair.hidden = false;
        _chkFacialHairYes.hidden = false;
        _chkFacialHairNo.hidden = false;
        
        _lblBodyHair.hidden = false;
        _chkBodyHairYes.hidden = false;
        _chkBodyHairNo.hidden = false;
    }
}

#pragma mark Save button Click Event
- (void)didTappedAppearanceSaveButton:(UIButton *)sender {
    NSLog(@"didTappedAppearanceSaveButton");
    NSMutableDictionary *dicData;
    
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"0"]) {
        dicData = @{@"id":[AppDelegate sharedDelegate].strUserid,
                 @"height_ft":_txtHeightFeet.txtField.text,
                 @"height_inch":_txtHeightInches.txtField.text,
                 @"weight_lbs":_txtWeight.txtField.text,
                 @"hair_color":_txtHairColor.txtField.text,
                 @"hair_length":_txtHairLength.txtField.text,
                 @"eye_color":_txtEyeColor.txtField.text,
                 @"body_type":_txtBodyType.txtField.text,
                 @"facial_hair":_strFacialHair,
                 @"body_hair":_strBodyHair,
                 @"tattoo":  _strTatoo,
                 @"tattoo_visible":_strTatooVisible,
                 @"piercings":_strPiercing,
                 @"piercings_visible":_strPiercingVisible,
                 @"hat_size":_txtHatSize.txtField.text,
                 @"glove_size":_txtGloveSize.txtField.text,
                 @"shoe_size":_txtShoeSize.txtField.text,
                 @"waist_size":_txtWaistSize.txtField.text,
                 @"shirt_size":_txtShirtSize.txtField.text,
                 @"coat_size":_txtCoatSize.txtField.text,
                 @"chest_size":_txtChestSize.txtField.text,
                 @"in_seam":_txtInSeam.txtField.text,
                 @"glasses_or_contacts":_txtGlasses.txtField.text,
                 @"disability":_txtSpecialCharacteristic.txtField.text,
                 @"disability_assistive_devices":_txtAssistiveDevices.txtField.text}.mutableCopy;
    }else if([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"])          {
        
        dicData = @{@"id":[AppDelegate sharedDelegate].strUserid,
                 @"height_ft":_txtHeightFeet.txtField.text,
                 @"height_inch":_txtHeightInches.txtField.text,
                 @"weight_lbs":_txtWeight.txtField.text,
                 @"hair_color":_txtHairColor.txtField.text,
                 @"hair_length":_txtHairLength.txtField.text,
                 @"eye_color":_txtEyeColor.txtField.text,
                 @"body_type":_txtBodyType.txtField.text,
                 @"cup_size":_txtCupSize.txtField.text,
                 @"bust_size":_txtBustSize.txtField.text,
                 @"tattoo":  _strTatoo,
                 @"tattoo_visible":_strTatooVisible,
                 @"piercings":_strPiercing,
                 @"piercings_visible":_strPiercingVisible,
                 @"hat_size":_txtHatSize.txtField.text,
                 @"glove_size":_txtGloveSize.txtField.text,
                 @"shoe_size":_txtShoeSize.txtField.text,
                 @"waist_size":_txtWaistSize.txtField.text,
                 @"shirt_size":_txtShirtSize.txtField.text,
                 @"coat_size":_txtCoatSize.txtField.text,
                 @"chest_size":_txtChestSize.txtField.text,
                 @"in_seam":_txtInSeam.txtField.text,
                 @"glasses_or_contacts":_txtGlasses.txtField.text,
                 @"disability":_txtSpecialCharacteristic.txtField.text,
                 @"disability_assistive_devices":_txtAssistiveDevices.txtField.text}.mutableCopy;
    }else {
        
        dicData = @{@"id":[AppDelegate sharedDelegate].strUserid,
                 @"height_ft":_txtHeightFeet.txtField.text,
                 @"height_inch":_txtHeightInches.txtField.text,
                 @"weight_lbs":_txtWeight.txtField.text,
                 @"hair_color":_txtHairColor.txtField.text,
                 @"hair_length":_txtHairLength.txtField.text,
                 @"eye_color":_txtEyeColor.txtField.text,
                 @"body_type":_txtBodyType.txtField.text,
                 @"cup_size":_txtCupSize.txtField.text,
                 @"bust_size":_txtBustSize.txtField.text,
                 @"facial_hair":_strFacialHair,
                 @"body_hair":_strBodyHair,
                 @"tattoo":  _strTatoo,
                 @"tattoo_visible":_strTatooVisible,
                 @"piercings":_strPiercing,
                 @"piercings_visible":_strPiercingVisible,
                 @"hat_size":_txtHatSize.txtField.text,
                 @"glove_size":_txtGloveSize.txtField.text,
                 @"shoe_size":_txtShoeSize.txtField.text,
                 @"waist_size":_txtWaistSize.txtField.text,
                 @"shirt_size":_txtShirtSize.txtField.text,
                 @"coat_size":_txtCoatSize.txtField.text,
                 @"chest_size":_txtChestSize.txtField.text,
                 @"in_seam":_txtInSeam.txtField.text,
                 @"glasses_or_contacts":_txtGlasses.txtField.text,
                 @"disability":_txtSpecialCharacteristic.txtField.text,
                 @"disability_assistive_devices":_txtAssistiveDevices.txtField.text}.mutableCopy;
    }
    NSLog(@"dicData = %@",dicData);
    
    if ([self.delegate respondsToSelector:@selector(didTappedActorAppearanceSaveButton:)]) {
        [self.delegate didTappedActorAppearanceSaveButton:dicData];
    }
}

-(void)updateActorAppearanceFrame {
    
    NSLog(@"updateActorAppearanceFrameupdateActorAppearanceFrame");
    
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
        
        _ttlCupSize.hidden = false;
        _txtCupSize.hidden = false;
        
        _ttlBustSize.hidden = false;
        _txtBustSize.hidden = false;
        
        
        
        _ttlCupSize.frame = CGRectMake(0, MaxY(_txtBodyType) + 20, WIDTH(self), 40);
        _txtCupSize.frame = CGRectMake(10, MaxY(_ttlCupSize) + 10, WIDTH(self) - 20, 70);
        _ttlBustSize.frame = CGRectMake(0, MaxY(_txtCupSize) + 20, WIDTH(self), 40);
        _txtBustSize.frame = CGRectMake(10, MaxY(_ttlBustSize) + 10, WIDTH(self) - 20, 70);
        _ttlFacial.frame = CGRectMake(0, MaxY(_txtBustSize) + 20, WIDTH(self), 40);
        
        _lblFacialHair.hidden = true;
        _chkFacialHairNo.hidden = true;
        _chkFacialHairYes.hidden = true;
        
        
        
        _lblBodyHair.hidden = true;
        _chkBodyHairNo.hidden = true;
        _chkBodyHairYes.hidden = true;
        
        _lblTatoo.frame = CGRectMake(10, MaxY(_ttlFacial) + 20, WIDTH(self), 20);
        
    }else{
        _ttlCupSize.hidden = true;
        _txtCupSize.hidden = true;
        
        _ttlBustSize.hidden = true;
        _txtBustSize.hidden = true;
        
        _lblFacialHair.hidden = false;
        _chkFacialHairNo.hidden = false;
        _chkFacialHairYes.hidden = false;
        
        _lblBodyHair.hidden = false;
        _chkBodyHairNo.hidden = false;
        _chkBodyHairYes.hidden = false;
        
        _ttlFacial.frame = CGRectMake(0, MaxY(_txtBodyType) + 20, WIDTH(self), 40);
        _lblFacialHair.frame = CGRectMake(10, MaxY(_ttlFacial) + 10, WIDTH(self), 20);
        _chkFacialHairYes.frame =  CGRectMake(20, MaxY(_lblFacialHair) + 20, (WIDTH(self) - 20) / 2, 30);
        _chkFacialHairNo.frame = CGRectMake(MaxX(_chkFacialHairYes), MaxY(_lblFacialHair) + 20, (WIDTH(self) - 20) / 2, 30);
        
        _lblBodyHair.frame = CGRectMake(10, MaxY(_chkFacialHairNo) + 20, WIDTH(self), 20);
        _chkBodyHairYes.frame = CGRectMake(20, MaxY(_lblBodyHair) + 20, (WIDTH(self) - 20) / 2, 30);
        _chkBodyHairNo.frame =  CGRectMake(MaxX(_chkBodyHairYes), MaxY(_lblBodyHair) + 20, (WIDTH(self) - 20) / 2, 30);
        
        _lblTatoo.frame = CGRectMake(10, MaxY(_chkBodyHairNo) + 20, WIDTH(self), 20);
        
    }
    
    _chkTatooYes.frame = CGRectMake(20, MaxY(_lblTatoo) + 20, (WIDTH(self) - 20) / 2, 30);
    _chkTatooNo.frame = CGRectMake(MaxX(_chkTatooYes), MaxY(_lblTatoo) + 20, (WIDTH(self) - 20) / 2, 30);
    _lblTatooVisible.frame = CGRectMake(10, MaxY(_chkTatooNo) + 20, WIDTH(self), 20);
    _chkTatooVisibleYes.frame = CGRectMake(20, MaxY(_lblTatooVisible) + 20, (WIDTH(self) - 20) / 2, 30);
    _chkTatooVisibleNo.frame = CGRectMake(MaxX(_chkTatooVisibleYes), MaxY(_lblTatooVisible) + 20, (WIDTH(self) - 20) / 2, 30);
    _lblPiercing.frame = CGRectMake(10, MaxY(_chkTatooVisibleNo) + 20, WIDTH(self), 20);
    _chkPiercingYes.frame = CGRectMake(20, MaxY(_lblPiercing) + 20, (WIDTH(self) - 20) / 2, 30);
    _chkPiercingNo.frame = CGRectMake(MaxX(_chkPiercingYes), MaxY(_lblPiercing) + 20, (WIDTH(self) - 20) /2, 30);
    _lblPiercingVisible.frame = CGRectMake(10, MaxY(_chkPiercingNo) + 20, WIDTH(self), 20);
    _chkPiercingVisibleYes.frame = CGRectMake(20, MaxY(_lblPiercingVisible) + 20, (WIDTH(self) - 20) / 2, 30);
    _chkPiercingVisibleNo.frame = CGRectMake(MaxX(_chkPiercingVisibleYes), MaxY(_lblPiercingVisible) + 20, (WIDTH(self) - 20) / 2, 30);
    _txtHatSize.frame = CGRectMake(10, MaxY(_chkPiercingVisibleNo) + 20, WIDTH(self) - 20, 70);
    _txtGloveSize.frame = CGRectMake(10, MaxY(_txtHatSize) + 10, WIDTH(self) - 20, 70);
    _txtShoeSize.frame = CGRectMake(10, MaxY(_txtGloveSize) + 10, WIDTH(self) - 20, 70);
    _txtWaistSize.frame = CGRectMake(10, MaxY(_txtShoeSize) + 10, WIDTH(self) - 20 - 10, 70);
    
    if ([[AppDelegate sharedDelegate].strGender isEqualToString:@"1"]) {
        _txtShirtSize.hidden = true;
        _txtCoatSize.frame = CGRectMake(10, MaxY(_txtWaistSize) + 10, WIDTH(self) - 20, 70);
    }else{
        _txtShirtSize.hidden = false;
        _txtShirtSize.frame = CGRectMake(10, MaxY(_txtWaistSize) + 10, WIDTH(self) - 20, 70);
        _txtCoatSize.frame = CGRectMake(10, MaxY(_txtShirtSize) + 10, WIDTH(self) - 20, 70);
    }
    _txtChestSize.frame = CGRectMake(10, MaxY(_txtCoatSize) + 20, WIDTH(self) - 20 - 10, 70);
    _txtInSeam.frame = CGRectMake(10, MaxY(_txtChestSize) + 20, WIDTH(self) - 20, 70);
    _txtGlasses.frame = CGRectMake(10, MaxY(_txtInSeam) + 10, WIDTH(self) - 20, 70);
    _txtSpecialCharacteristic.frame = CGRectMake(10, MaxY(_txtGlasses) + 10, WIDTH(self) - 20, 70);
    _txtAssistiveDevices.frame = CGRectMake(10, MaxY(_txtSpecialCharacteristic) + 10, WIDTH(self) - 20, 70);
    _btnSave.frame = CGRectMake(20, MaxY(_txtAssistiveDevices) + 20, WIDTH(self) - 40, 50);
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
}

#pragma mark SHMultipleSelectDelegate
- (void)multipleSelectView:(SHMultipleSelect*)multipleSelectView clickedBtnAtIndex:(NSInteger)clickedBtnIndex withSelectedIndexPaths:(NSArray*)selectedIndexPaths {
    NSLog(@"clickedBtnIndex = %ld",(long)clickedBtnIndex);
    if (clickedBtnIndex == 1) { // Done btn
        _pickerText = @"";
        for (NSIndexPath *indexPath in selectedIndexPaths) {
            NSLog(@"%@", _aryData[indexPath.row]);
            //_pickerText = _aryData[indexPath.row];
            //_pickerText = [_pickerText stringByAppendingString:@"dharmesh "];
            _pickerText = [_pickerText stringByAppendingString:[NSString stringWithFormat:@"%@,",_aryData[indexPath.row]]];
            NSLog(@"**_pickerText = %@",_pickerText);
        }
        if (multipleSelectView.tag == 1) {
            _txtSpecialCharacteristic.txtField.text = _pickerText;
            //[_txtSpecialCharacteristic.txtField sizeToFit];
        }else
            _txtAssistiveDevices.txtField.text = _pickerText;
    }
    
    NSLog(@"@@@_pickerText = %@",_pickerText);
}
- (NSString*)multipleSelectView:(SHMultipleSelect*)multipleSelectView titleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return _aryData[indexPath.row];
}
- (BOOL)multipleSelectView:(SHMultipleSelect*)multipleSelectView setSelectedForRowAtIndexPath:(NSIndexPath*)indexPath {
    BOOL canSelect = NO;
    if (indexPath.row == _aryData.count - 1) { // last object
        canSelect = NO;
    }
    return canSelect;
}

@end
