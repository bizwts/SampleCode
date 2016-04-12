//
//  UpdateActorAboutYView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "UpdateActorAboutYView.h"

@implementation UpdateActorAboutYView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _first = @"";
        _second = @"";
        _third = @"";
        _pickerText = @"";
        _selectedDate = @"";
        self.aryFirstLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        self.arySecondLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        self.aryThirdLetter = @[@"",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        [self addUIControl];
    }
    return self;
}

- (void)addUIControl {
    [self addSubview:[self scrollView]];
    
    _aryTypeOfWork = @[].mutableCopy;
    
    [_scrollView addSubview:[self ttlCredit]];
    [_scrollView addSubview:[self txtCredit]];
    [_scrollView addSubview:[self ttlBestSkill]];
    [_scrollView addSubview:[self txtSkil]];
    
    [_scrollView addSubview:[self ttlUnique]];
    [_scrollView addSubview:[self txtUnique]];
    
    [_scrollView addSubview:[self ttlTraining]];
    [_scrollView addSubview:[self chkTrainingYes]];
    [_scrollView addSubview:[self chkTrainingNo]];
    [_scrollView addSubview:[self chkTrainingBoth]];
    
    [_scrollView addSubview:[self ttlSeeking]];
    [_scrollView addSubview:[self chkSeekingManager]];
    [_scrollView addSubview:[self chkSeekingAgent]];
    [_scrollView addSubview:[self chkSeekingBoth]];
    
    [_scrollView addSubview:[self ttlTypeOfWork]];
    [_scrollView addSubview:[self chkCommercialTypeOfWork]];
    [_scrollView addSubview:[self chkTheatricalTypeOfWork]];
    [_scrollView addSubview:[self chkModelTypeOfWork]];
    [_scrollView addSubview:[self chkBackgroundTypeOfWork]];
    
    [_scrollView addSubview:[self chkRealityTVTypeOfWork]];
    [_scrollView addSubview:[self chkVoiceOverTypeOfWork]];
    [_scrollView addSubview:[self chkComedyTypeOfWork]];
    [_scrollView addSubview:[self chkMusicalArtistTypeOfWork]];
    
    [_scrollView addSubview:[self chkDancerTypeOfWork]];
    
    [_scrollView addSubview:[self ttlSigned]];
    [_scrollView addSubview:[self chkSignedYes]];
    [_scrollView addSubview:[self chkSignedNo]];
    
    [_scrollView addSubview:[self ttlRepresentation]];
    [_scrollView addSubview:[self txtRepresentation]];
    
    [_scrollView addSubview:[self ttlPassport]];
    [_scrollView addSubview:[self chkPassportYes]];
    [_scrollView addSubview:[self chkPassportNo]];
    [_scrollView addSubview:[self txtStartDate]];
    [_scrollView addSubview:[self txtEndDate]];
    
    [_scrollView addSubview:[self btnSave]];
    [self setupKeyboardSettings];
    
    [self updateData];
    
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
}

- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[_txtCredit.txtField,
                            _txtSkil.txtView,
                            _txtUnique.txtView,
                            _txtRepresentation.txtField,
                            _txtStartDate.txtField,
                            _txtEndDate.txtField
                            ];
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
        _btnSave.frame = CGRectMake(20, MaxY(_txtEndDate) + 20, WIDTH(self) - 40, 50);
        [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSave addTarget:self action:@selector(didTappedAboutSaveButton:) forControlEvents:UIControlEventTouchUpInside];
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

- (DMTitleView *)ttlCredit {
    if (!_ttlCredit) {
        _ttlCredit = [[DMTitleView alloc] initWithFrame:CGRectMake(0, 10, WIDTH(self), 40) data:@"Credits"];
        _ttlCredit.lblTitle.numberOfLines = 2.0f;
        _ttlCredit.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlCredit.backgroundColor = TitleColor;
    }
    return _ttlCredit;
}

- (DMTextField *)txtCredit {
    if (!_txtCredit) {
        _txtCredit = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlCredit) + 10, (WIDTH(self) - 20), 70) data:@{@"Icon":@"Credits",@"Name":@"Credit"}];
        _txtCredit.txtField.delegate = self;
        _txtCredit.txtField.tag = 1;
        _txtCredit.txtField.inputView = [self pickerDataMultiPleColumn];
    }
    return _txtCredit;
}

- (DMTitleView *)ttlBestSkill {
    if (!_ttlBestSkill) {
        _ttlBestSkill = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtCredit) + 20, WIDTH(self), 60) data:@"List your 3 best skills -  to show up on picture for talent reps"];
        _ttlBestSkill.lblTitle.numberOfLines = 3.0f;
        _ttlBestSkill.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlBestSkill.backgroundColor = TitleColor;
    }
    return _ttlBestSkill;
}

- (DMTextField *)txtSkil {
    if (!_txtSkil) {
        _txtSkil = [[DMTextField alloc] initWithFrameMultipleLine:CGRectMake(10, MaxY(_ttlBestSkill) + 10, (WIDTH(self) - 20), 70) data:@{@"Icon":@"Skills",@"Name":@"Skill"}];
        _txtSkil.txtField.delegate = self;
        _txtSkil.txtField.tag = 2;
    }
    return _txtSkil;
}

- (DMTitleView *)ttlUnique {
    if (!_ttlUnique) {
        _ttlUnique = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtSkil) + 20, WIDTH(self), 60) data:@"What is most unique about you?"];
        _ttlUnique.lblTitle.numberOfLines = 3.0f;
        _ttlUnique.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlUnique.backgroundColor = TitleColor;
    }
    return _ttlUnique;
}

- (DMTextField *)txtUnique {
    if (!_txtUnique) {
        _txtUnique = [[DMTextField alloc] initWithFrameMultipleLine:CGRectMake(10, MaxY(_ttlUnique) + 10, (WIDTH(self) - 20), 70) data:@{@"Icon":@"Unique",@"Name":@"Unique"}];
        _txtUnique.txtField.delegate = self;
        _txtUnique.txtField.tag = 2;
    }
    return _txtUnique;
}

- (DMTitleView *)ttlTraining {
    if (!_ttlTraining) {
        _ttlTraining = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtUnique) + 20, WIDTH(self), 40) data:@"Any Previous Training? Technique,Improv"];
        _ttlTraining.lblTitle.numberOfLines = 2.0f;
        _ttlTraining.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlTraining.backgroundColor = TitleColor;
    }
    return _ttlTraining;
}

- (DMCheckBox *)chkTrainingYes {
    if (!_chkTrainingYes) {
        _chkTrainingYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_ttlTraining) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkTrainingYes.tag = 0;
        [_chkTrainingYes addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTrainingYes;
}

- (DMCheckBox *)chkTrainingNo {
    if (!_chkTrainingNo) {
        _chkTrainingNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkTrainingYes), MaxY(_ttlTraining) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkTrainingNo.tag = 1;
        [_chkTrainingNo addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTrainingNo;
}

- (DMCheckBox *)chkTrainingBoth {
    if (!_chkTrainingBoth) {
        _chkTrainingBoth = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkTrainingNo), MaxY(_ttlTraining) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Both"}];
        _chkTrainingBoth.tag = 2;
        [_chkTrainingBoth addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTrainingBoth;
}

- (DMTitleView *)ttlSeeking {
    if (!_ttlSeeking) {
        _ttlSeeking = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_chkTrainingBoth) + 20, WIDTH(self), 40) data:@"Im Seeking"];
        _ttlSeeking.lblTitle.numberOfLines = 2.0f;
        _ttlSeeking.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlSeeking.backgroundColor = TitleColor;
    }
    return _ttlSeeking;
}

- (DMCheckBox *)chkSeekingManager {
    if (!_chkSeekingManager) {
        _chkSeekingManager = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_ttlSeeking) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Manager"}];
        _chkSeekingManager.tag = 3;
        _chkSeekingManager.lblTitle.font = [UIFont systemFontOfSize:12.0f];
        [_chkSeekingManager addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkSeekingManager;
}

- (DMCheckBox *)chkSeekingAgent {
    if (!_chkSeekingAgent) {
        _chkSeekingAgent = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkSeekingManager), MaxY(_ttlSeeking) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Agent"}];
        _chkSeekingAgent.tag = 4;
        [_chkSeekingAgent addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkSeekingAgent;
}

- (DMCheckBox *)chkSeekingBoth {
    if (!_chkSeekingBoth) {
        _chkSeekingBoth = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkSeekingAgent), MaxY(_ttlSeeking) + 10, (WIDTH(self) - 20) / 3, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Both"}];
        _chkSeekingBoth.tag = 5;
        [_chkSeekingBoth addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkSeekingBoth;
}

- (DMTitleView *)ttlTypeOfWork {
    if (!_ttlTypeOfWork) {
        _ttlTypeOfWork = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_chkSeekingBoth) + 20, WIDTH(self), 40) data:@"Type of Work"];
        _ttlTypeOfWork.lblTitle.numberOfLines = 2.0f;
        _ttlTypeOfWork.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlTypeOfWork.backgroundColor = TitleColor;
    }
    return _ttlTypeOfWork;
}

- (DMCheckBox *)chkCommercialTypeOfWork {
    if (!_chkCommercialTypeOfWork) {
        _chkCommercialTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_ttlTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Commercial"}];
        _chkCommercialTypeOfWork.tag = 10;
        [_chkCommercialTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkCommercialTypeOfWork;
}

- (DMCheckBox *)chkTheatricalTypeOfWork {
    if (!_chkTheatricalTypeOfWork) {
        _chkTheatricalTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_chkCommercialTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Theatrical"}];
        _chkTheatricalTypeOfWork.tag = 11;
        [_chkTheatricalTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkTheatricalTypeOfWork;
}

- (DMCheckBox *)chkModelTypeOfWork {
    if (!_chkModelTypeOfWork) {
        _chkModelTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_chkTheatricalTypeOfWork) + 10, (WIDTH(self) - 20) /2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Model"}];
        _chkModelTypeOfWork.tag = 12;
        [_chkModelTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkModelTypeOfWork;
}

- (DMCheckBox *)chkBackgroundTypeOfWork {
    if (!_chkBackgroundTypeOfWork) {
        _chkBackgroundTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_chkModelTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Background"}];
        _chkBackgroundTypeOfWork.tag = 13;
        //_chkRealityTVTypeOfWork.layer.borderWidth = 1.0f;
        [_chkBackgroundTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkBackgroundTypeOfWork;
}

- (DMCheckBox *)chkRealityTVTypeOfWork {
    if (!_chkRealityTVTypeOfWork) {
        _chkRealityTVTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(WIDTH(self) / 2, MaxY(_ttlTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Reality TV"}];
        _chkRealityTVTypeOfWork.tag = 14;
        //_chkRealityTVTypeOfWork.layer.borderWidth = 1.0f;
        [_chkRealityTVTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkRealityTVTypeOfWork;
}

- (DMCheckBox *)chkVoiceOverTypeOfWork {
    if (!_chkVoiceOverTypeOfWork) {
        _chkVoiceOverTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(WIDTH(self) / 2, MaxY(_chkRealityTVTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Voice Over"}];
        _chkVoiceOverTypeOfWork.tag = 15;
        [_chkVoiceOverTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkVoiceOverTypeOfWork;
}

- (DMCheckBox *)chkComedyTypeOfWork {
    if (!_chkComedyTypeOfWork) {
        _chkComedyTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(WIDTH(self) / 2, MaxY(_chkVoiceOverTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Comedy"}];
        _chkComedyTypeOfWork.tag = 16;
        [_chkComedyTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkComedyTypeOfWork;
}

- (DMCheckBox *)chkMusicalArtistTypeOfWork {
    if (!_chkMusicalArtistTypeOfWork) {
        _chkMusicalArtistTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(WIDTH(self) / 2, MaxY(_chkComedyTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Musical artist"}];
        _chkMusicalArtistTypeOfWork.tag =17;
        //_chkRealityTVTypeOfWork.layer.borderWidth = 1.0f;
        [_chkMusicalArtistTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkMusicalArtistTypeOfWork;
}

- (DMCheckBox *)chkDancerTypeOfWork {
    if (!_chkDancerTypeOfWork) {
        _chkDancerTypeOfWork = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_chkBackgroundTypeOfWork) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Dancer"}];
        _chkDancerTypeOfWork.tag =18;
        //_chkRealityTVTypeOfWork.layer.borderWidth = 1.0f;
        [_chkDancerTypeOfWork addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkDancerTypeOfWork;
}

- (DMTitleView *)ttlSigned {
    if (!_ttlSigned) {
        _ttlSigned = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_chkDancerTypeOfWork) + 20, WIDTH(self), 40) data:@"Any you currently signed?"];
        _ttlSigned.lblTitle.numberOfLines = 2.0f;
        _ttlSigned.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlSigned.backgroundColor = TitleColor;
    }
    return _ttlSigned;
}

- (DMCheckBox *)chkSignedYes {
    if (!_chkSignedYes) {
        _chkSignedYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_ttlSigned) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkSignedYes.tag = 6;
        [_chkSignedYes addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkSignedYes;
}

- (DMCheckBox *)chkSignedNo {
    if (!_chkSignedNo) {
        _chkSignedNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkSignedYes), MaxY(_ttlSigned) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkSignedNo.tag = 7;
        [_chkSignedNo addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkSignedNo;
}

- (DMTitleView *)ttlRepresentation {
    if (!_ttlRepresentation) {
        _ttlRepresentation = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_chkSignedNo) + 20, WIDTH(self), 40) data:@"Are you Representation ready??"];
        _ttlRepresentation.backgroundColor = TitleColor;
    }
    return _ttlRepresentation;
}

- (DMTextField *)txtRepresentation {
    if (!_txtRepresentation) {
        _txtRepresentation = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_ttlRepresentation) + 10, WIDTH(self) - 20, 70) data:@{@"Icon":@"Representation",@"Name":@"Representation"}];
        _txtRepresentation.txtField.delegate = self;
        _txtRepresentation.txtField.tag = 2;
        //_txtRepresentation.txtField.inputAccessoryView  = [self toolBar];
        //_txtRepresentation.txtField.inputView = [self pickerData];
    }
    return _txtRepresentation;
}

- (DMTitleView *)ttlPassport {
    if (!_ttlPassport) {
        _ttlPassport = [[DMTitleView alloc] initWithFrame:CGRectMake(0, MaxY(_txtRepresentation) + 20, WIDTH(self), 40) data:@"Do you have passport?"];
        _ttlPassport.lblTitle.numberOfLines = 2.0f;
        _ttlPassport.lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _ttlPassport.backgroundColor = TitleColor;
    }
    return _ttlPassport;
}

- (DMCheckBox *)chkPassportYes {
    if (!_chkPassportYes) {
        _chkPassportYes = [[DMCheckBox alloc] initWithFrame:CGRectMake(10, MaxY(_ttlPassport) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"Yes"}];
        _chkPassportYes.tag = 8;
        [_chkPassportYes addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPassportYes;
}

- (DMCheckBox *)chkPassportNo {
    if (!_chkPassportNo) {
        _chkPassportNo = [[DMCheckBox alloc] initWithFrame:CGRectMake(MaxX(_chkPassportYes), MaxY(_ttlPassport) + 10, (WIDTH(self) - 20) / 2, 30) dic:@{@"Icon":@"UnCheck",@"Title":@"No"}];
        _chkPassportNo.tag = 9;
        [_chkPassportNo addTarget:self action:@selector(changedCheckBoxValue:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chkPassportNo;
}

- (DMTextField *)txtStartDate {
    if (!_txtStartDate) {
        _txtStartDate = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_chkPassportNo) + 20, (WIDTH(self)) / 2 - 20, 70) data:@{@"Icon":@"Date",@"Name":@"Start Date"}];
        _txtStartDate.txtField.delegate = self;
        _txtStartDate.txtField.tag = 3;
        _txtStartDate.txtField.inputView = [self datePicker];
        
        _vPassportLine = [[UIView alloc] initWithFrame:CGRectMake(WIDTH(self) / 2 - 1, Y(_txtStartDate), 1, HEIGHT(_txtStartDate))];
        _vPassportLine.backgroundColor = TitleColor;
        [_scrollView addSubview:_vPassportLine];
    }
    return _txtStartDate;
}

- (DMTextField *)txtEndDate {
    if (!_txtEndDate) {
        _txtEndDate = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(WIDTH(self) / 2 + 10, MaxY(_chkPassportNo) + 20, (WIDTH(self)) / 2 -20, 70) data:@{@"Icon":@"Date",@"Name":@"End Date"}];
        _txtEndDate.txtField.delegate = self;
        _txtEndDate.txtField.tag = 4;
        //_txtEndDate.layer.borderWidth = 1.0f;
        _txtEndDate.txtField.inputView = [self datePicker];
    }
    return _txtEndDate;
}

#pragma mark CheckedBox event
- (void)changedCheckBoxValue:(UIButton *)sender {
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    
    UIImage *secondImage = [UIImage imageNamed:@"Check"];
    NSData *imgData2 = UIImagePNGRepresentation(secondImage);
    
    switch (sender.tag) {
        case 0:{
            _chkTrainingYes.img.image = [UIImage imageNamed:@"Check"];
            _chkTrainingNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTrainingBoth.img.image = [UIImage imageNamed:@"UnCheck"];
            _strTraining = @"1";
        }
            break;
        case 1:{
            _chkTrainingYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTrainingNo.img.image = [UIImage imageNamed:@"Check"];
            _chkTrainingBoth.img.image = [UIImage imageNamed:@"UnCheck"];
            _strTraining = @"0";
        }
            break;
        case 2:{
            _chkTrainingYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTrainingNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkTrainingBoth.img.image = [UIImage imageNamed:@"Check"];
            _strTraining = @"2";
        }
            break;
        case 3:{
            _chkSeekingManager.img.image = [UIImage imageNamed:@"Check"];
            _chkSeekingAgent.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkSeekingBoth.img.image = [UIImage imageNamed:@"UnCheck"];
            _strSeeking = @"0";
        }
            break;
        case 4:{
            _chkSeekingManager.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkSeekingAgent.img.image = [UIImage imageNamed:@"Check"];
            _chkSeekingBoth.img.image = [UIImage imageNamed:@"UnCheck"];
            _strSeeking = @"1";
        }
            break;
        case 5:{
            _chkSeekingManager.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkSeekingAgent.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkSeekingBoth.img.image = [UIImage imageNamed:@"Check"];
            _strSeeking = @"2";
            
        }
            break;
        case 6:{
            _chkSignedYes.img.image = [UIImage imageNamed:@"Check"];
            _chkSignedNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strSigned = @"1";
        }
            break;
        case 7:{
            _chkSignedYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkSignedNo.img.image = [UIImage imageNamed:@"Check"];
            _strSigned = @"0";
        }
            break;
        case 8:{
            _chkPassportYes.img.image = [UIImage imageNamed:@"Check"];
            _chkPassportNo.img.image = [UIImage imageNamed:@"UnCheck"];
            _strPassport = @"1";
            [self passportValidation];
            
        }
            break;
        case 9:{
            _chkPassportYes.img.image = [UIImage imageNamed:@"UnCheck"];
            _chkPassportNo.img.image = [UIImage imageNamed:@"Check"];
            _strPassport = @"0";
            [self passportValidation];
            
        }
            break;
        case 10:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkCommercialTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkCommercialTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"0"])
                    [_aryTypeOfWork removeObject:@"0"];
            }else {
                _chkCommercialTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"0"])
                    [_aryTypeOfWork addObject:@"0"];
            }
        }
            break;
        case 11:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkTheatricalTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkTheatricalTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"1"])
                    [_aryTypeOfWork removeObject:@"1"];
            }else {
                _chkTheatricalTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"1"])
                    [_aryTypeOfWork addObject:@"1"];
            }
        }
            break;
        case 12:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkModelTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkModelTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"2"])
                    [_aryTypeOfWork removeObject:@"2"];
            }else {
                _chkModelTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"2"])
                    [_aryTypeOfWork addObject:@"2"];
            }
        }
            break;
        case 13:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkBackgroundTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkBackgroundTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"3"])
                    [_aryTypeOfWork removeObject:@"3"];
            }else {
                _chkBackgroundTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"3"])
                    [_aryTypeOfWork addObject:@"3"];
            }
        }
            break;
        case 14:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkRealityTVTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkRealityTVTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"4"])
                    [_aryTypeOfWork removeObject:@"4"];
            }else {
                _chkRealityTVTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"4"])
                    [_aryTypeOfWork addObject:@"4"];
            }
        }
            break;
        case 15:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkVoiceOverTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkVoiceOverTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"5"])
                    [_aryTypeOfWork removeObject:@"5"];
            }else {
                _chkVoiceOverTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"5"])
                    [_aryTypeOfWork addObject:@"5"];
            }
        }
            break;
        case 16:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkComedyTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkComedyTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"6"])
                    [_aryTypeOfWork removeObject:@"6"];
            }else {
                _chkComedyTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"6"])
                    [_aryTypeOfWork addObject:@"6"];
            }
        }
            break;
        case 17:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkMusicalArtistTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkMusicalArtistTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"7"])
                    [_aryTypeOfWork removeObject:@"7"];
            }else {
                _chkMusicalArtistTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"7"])
                    [_aryTypeOfWork addObject:@"7"];
            }
        }
            break;
        case 18:{
            NSData *imgData1 = UIImagePNGRepresentation(_chkDancerTypeOfWork.img.image);
            BOOL isCompare =  [imgData1 isEqual:imgData2];
            if (isCompare) {
                _chkDancerTypeOfWork.img.image = [UIImage imageNamed:@"UnCheck"];
                if([_aryTypeOfWork containsObject:@"8"])
                    [_aryTypeOfWork removeObject:@"8"];
            }else {
                _chkDancerTypeOfWork.img.image = [UIImage imageNamed:@"Check"];
                
                if(![_aryTypeOfWork containsObject:@"8"])
                    [_aryTypeOfWork addObject:@"8"];
            }
        }
            break;
        default:
            break;
    }
    
    NSLog(@"_aryTypeOfWork = %@",_aryTypeOfWork);
}

#pragma mark UIDatePicker

- (UIDatePicker *)datePicker {
    _datePicker = [[UIDatePicker alloc]init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return _datePicker;
}

- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker{
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"date = %@",datePicker.date);
    _selectedDate = [dateFormate stringFromDate:datePicker.date];
}

#pragma mark UIPickerView
- (UIPickerView *)pickerData {
    _pickerData = [[UIPickerView alloc] init];
    _pickerData.dataSource = self;
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


#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
    _pickerComponent = 1;
    switch (textField.tag) {
        case 1: {
            _pickerComponent = 2;
            _txtCredit.hLine.backgroundColor = BaseColor;
        }
            break;
        case 2: {
            _aryData = @[@"Reel",@"Monologue",@"Scene",@"Improv",@"None",@"N/A"].
            mutableCopy;
            _txtRepresentation.hLine.backgroundColor = BaseColor;
            SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
            multipleSelect.delegate = self;
            multipleSelect.tag = 1;
            multipleSelect.rowsCount = _aryData.count;
            [multipleSelect show];
            return false;
        }
            break;
        case 3: {
            _pickerComponent = 1;
            _txtStartDate.hLine.backgroundColor = BaseColor;
        }
            break;
        case 4: {
            _pickerComponent = 1;
            _txtEndDate.hLine.backgroundColor = BaseColor;
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
    
    switch (textField.tag) {
        case 1: {
            if (_pickerText.length>0) {
                _txtCredit.txtField.text = _pickerText;
                _txtCredit.hLine.backgroundColor = GrayColor;
            }
        }
            break;
        case 3: {
            if (_selectedDate.length > 0) {
                _txtStartDate.txtField.text = _selectedDate;
                _txtStartDate.hLine.backgroundColor = GrayColor;
            }
        }
            break;
        case 4: {
            if (_selectedDate.length > 0) {
                _txtEndDate.txtField.text = _selectedDate;
                _txtEndDate.hLine.backgroundColor = GrayColor;
            }
        }
            break;
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
        else if(component == 1)
            return [self.arySecondLetter objectAtIndex:row];
        else if (component == 2)
            return [self.aryThirdLetter objectAtIndex:row];
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
        }else if (component == 1)
            _second = _arySecondLetter[row];
        else if (component == 2)
            _third = _aryThirdLetter[row];
        
        if (component == 2) {
            _pickerText = [NSString stringWithFormat:@"%@%@%@",_first,_second,_third];
            _pickerText = [[[@"" stringByAppendingString:_first]stringByAppendingString: _second] stringByAppendingString:_third];
        }else {
            _pickerText = [NSString stringWithFormat:@"%@%@",_first,_second];
            _pickerText = [[@"" stringByAppendingString:_first]stringByAppendingString: _second];
        }
    }
}

- (void)updateData{
    
    NSLog(@"updateDataupdateDataupdateData");
    
    _txtCredit.txtField.text = [AppDelegate sharedDelegate].strCredits;
    _txtSkil.txtView.text = [AppDelegate sharedDelegate].strSkills;
    _txtUnique.txtView.text = [AppDelegate sharedDelegate].strUnique;
    _txtRepresentation.txtField.text = [AppDelegate sharedDelegate].strPresentationReady;
    _txtStartDate.txtField.text = [AppDelegate sharedDelegate].strCurrentPassportStartDate;
    _txtEndDate.txtField.text = [AppDelegate sharedDelegate].strCurrentPassportEndDate;
    
    if ([[AppDelegate sharedDelegate].strTraining isEqualToString:@"1"]) {
        _chkTrainingYes.img.image = [UIImage imageNamed:CheckImage];
        _strTraining = @"1";
    }else if ([[AppDelegate sharedDelegate].strTraining isEqualToString:@"0"]){
        _chkTrainingNo.img.image = [UIImage imageNamed:CheckImage];
        _strTraining = @"0";
    }
    else if ([[AppDelegate sharedDelegate].strTraining isEqualToString:@"2"]){
        _chkTrainingBoth.img.image = [UIImage imageNamed:CheckImage];
        _strTraining = @"2";
    }
    if ([[AppDelegate sharedDelegate].strimseeking isEqualToString:@"0"]) {
        _chkSeekingManager.img.image = [UIImage imageNamed:CheckImage];
        _strSeeking = @"0";
    }else if ([[AppDelegate sharedDelegate].strimseeking isEqualToString:@"1"]){
        _chkSeekingAgent.img.image = [UIImage imageNamed:CheckImage];
        _strSeeking = @"1";
    }
    else if ([[AppDelegate sharedDelegate].strimseeking isEqualToString:@"2"]){
        _chkSeekingBoth.img.image = [UIImage imageNamed:CheckImage];
        _strSeeking = @"2";
    }
    if ([[AppDelegate sharedDelegate].strCurrentlySigned isEqualToString:@"1"]) {
        _chkSignedYes.img.image = [UIImage imageNamed:CheckImage];
        _strSigned = @"1";
    }else if ([[AppDelegate sharedDelegate].strCurrentlySigned isEqualToString:@"0"]){
        _chkSignedNo.img.image = [UIImage imageNamed:CheckImage];
        _strSigned = @"0";
    }
    if ([[AppDelegate sharedDelegate].strCurrentPassport isEqualToString:@"1"]) {
        _chkPassportYes.img.image = [UIImage imageNamed:CheckImage];
        _strPassport = @"1";
        [self passportValidation];
    }else if ([[AppDelegate sharedDelegate].strCurrentPassport isEqualToString:@"0"]){
        _chkPassportNo.img.image = [UIImage imageNamed:CheckImage];
        _strPassport = @"0";
        [self passportValidation];
    }
    
    //[line stringByTrimmingCharactersInSet:
    //[NSCharacterSet whitespaceCharacterSet]]
    
   _aryTypeOfWork = [[AppDelegate sharedDelegate].strWorkType componentsSeparatedByString:@","].mutableCopy;
    
    NSLog(@"****aryTypeWork = %@",_aryTypeOfWork);
    
    if([_aryTypeOfWork containsObject:@"0"]){
        NSLog(@"0");
        _chkCommercialTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    
    if ([_aryTypeOfWork containsObject:@"1"] ){
        NSLog(@"1");
        _chkTheatricalTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    
    if ([_aryTypeOfWork containsObject:@"2"]){
        NSLog(@"2");
        _chkModelTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    
    if ([_aryTypeOfWork containsObject:@"3"]){
        NSLog(@"3");
        _chkBackgroundTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    if ([_aryTypeOfWork containsObject:@"4"]) {
        NSLog(@"4");
        _chkRealityTVTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    
    if ([_aryTypeOfWork containsObject:@"5"]) {
        NSLog(@"5");
        _chkVoiceOverTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }

    if ([_aryTypeOfWork containsObject:@"6"]) {
        NSLog(@"6");
         _chkComedyTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    if ([_aryTypeOfWork containsObject:@"7"]) {
        NSLog(@"7");
        _chkMusicalArtistTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    if ([_aryTypeOfWork containsObject:@"8"]) {
        NSLog(@"8");
        _chkDancerTypeOfWork.img.image = [UIImage imageNamed:CheckImage];
    }
    
}

#pragma mark Save button Click Event
- (void)didTappedAboutSaveButton:(UIButton *)sender {
    NSLog(@"didTappedAboutSaveButton");
    _strTypeOfWork = @"";
    int i=1;
    for (NSString *str in _aryTypeOfWork) {
        NSLog(@"str = %@",str);
        if (str.length>0) {
            _strTypeOfWork = [_strTypeOfWork stringByAppendingString:str];
            if (i!=_aryTypeOfWork.count)
                _strTypeOfWork = [_strTypeOfWork stringByAppendingString:@","];
        }
        i++;
    }
    NSLog(@"_strTypeOfWork = %@",_strTypeOfWork);
     
    NSMutableDictionary *dic = @{@"id":[AppDelegate sharedDelegate].strUserid,
                                 @"training":_strTraining,
                                 @"seeking":_strSeeking,
                                 @"type_of_work":_strTypeOfWork,
                                 @"current_status":_strSigned,
                                 @"representation":_txtRepresentation.txtField.text,
                                 @"credits":_txtCredit.txtField.text,
                                 @"skills":_txtSkil.txtView.text,
                                 @"unique":_txtUnique.txtView.text,
                                 @"passport":_strPassport,
                                 @"startdate":_txtStartDate.txtField.text,
                                 @"enddate" : _txtEndDate.txtField.text}.mutableCopy;
    NSLog(@"dic = %@",dic);
    
    if ([self.delegate respondsToSelector:@selector(didTappedActorAboutYouSaveButton:)]) {
        [self.delegate didTappedActorAboutYouSaveButton:dic];
    }
}

-(void)passportValidation {
    if ([_strPassport isEqualToString:@"1"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        _txtEndDate.hidden = false;
        _txtStartDate.hidden = false;
        _vPassportLine.hidden = false;
        _btnSave.frame = CGRectMake(20, MaxY(_txtStartDate) + 40, WIDTH(self) - 40, 50);
         [UIView commitAnimations];
        _scrollView.frame = CGRectMake(0, 0, WIDTH(self), HEIGHT(self));
        _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
        
    }else{
        _txtEndDate.hidden = true;
        _txtStartDate.hidden = true;
        _vPassportLine.hidden = true;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        _btnSave.frame = CGRectMake(20, MaxY(_chkPassportNo) + 30, WIDTH(self) - 40, 50);
        [UIView commitAnimations];
        _scrollView.frame = CGRectMake(0, 0, WIDTH(self), HEIGHT(self));
        _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
    }
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
        _txtRepresentation.txtField.text = _pickerText;
        //[_txtSpecialCharacteristic.txtField sizeToFit];
        
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
