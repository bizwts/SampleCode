//
//  UpdateActorResumeView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//No resume attached. Please upload your resume.


#import "UpdateActorResumeView.h"

@interface UpdateActorResumeView()

@end

@implementation UpdateActorResumeView

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
    [_scrollView addSubview:[self dottedView]];
    [_scrollView addSubview:[self txtLinkToReel]];
    [_scrollView addSubview:[self txtIMDBLink]];
    [_scrollView addSubview:[self btnSave]];
    //[self addDashedBorder];
    [self setupKeyboardSettings];
    [self updateResumeData];
    NSLog(@"strResumePath = %@",[AppDelegate sharedDelegate].strResumePath);
    
    _scrollView.contentSize =CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateResumeData) name:notiUpdateActorResumeData object:nil];
}

- (void)setupKeyboardSettings {
    PNTToolbar *toolbar = [PNTToolbar defaultToolbar];
    toolbar.navigationButtonsTintColor = BaseColor;
    toolbar.mainScrollView = self.scrollView;
    toolbar.inputFields = @[_txtLinkToReel.txtField,
                            _txtIMDBLink.txtField
                            ];
    [_scrollView setContentSize:CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20)];
}

- (UIView *)dottedView {
    if (!_dottedView) {
        _dottedView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, WIDTH(self) - 40,HEIGHT(_scrollView))];
        [_dottedView addSubview:[self btnClick]];
        [_dottedView addSubview:[self lblCVName]];
        [_dottedView addSubview:[self OperationView]];
        _dottedView.frame = CGRectMake(20, 20, WIDTH(self) - 40, HEIGHT(_btnClick) + HEIGHT(_OperationView) + 50);
    }
    return _dottedView;
}

- (UILabel *)lblCVName {
    if (!_lblCVName) {
        _lblCVName = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_btnClick) + 10, 10, WIDTH(_dottedView) - MaxX(_btnClick) - 20, 80)];
        //_lblCVName.layer.borderWidth = 1.0f;
        _lblCVName.font = [UIFont systemFontOfSize:14.0];
        if ([[AppDelegate sharedDelegate].strResumePath lastPathComponent].length == 0) {
            _lblCVName.text = NoResumeMessage;
        }else
            _lblCVName.text = [[AppDelegate sharedDelegate].strResumePath lastPathComponent];
        _lblCVName.numberOfLines = 6;
        _lblCVName.lineBreakMode = NSLineBreakByWordWrapping;
        _lblCVName.textColor = BaseColor;
    }
    return _lblCVName;
}

- (UIButton *)btnClick {
    if (!_btnClick) {
        _btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClick.frame = CGRectMake(10, 10, 80, 80);
        //_btnClick.layer.borderWidth = 1.0f;
        [_btnClick addTarget:self action:@selector(didTappedClickButton) forControlEvents:UIControlEventTouchUpInside];
        _btnClick.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_btnClick setImage:[UIImage imageNamed:@"Document"] forState:UIControlStateNormal];
    }
    return _btnClick;
}

- (void)didTappedClickButton {
    //    DocumentPickerViewController *document = [[DocumentPickerViewController alloc]init];
    //    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:document];
    //    [self presentViewController:navControl animated:YES completion:nil];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
        _scrollView.pagingEnabled = true;
    }
    return _scrollView;
}

- (UIButton *)btnSave {
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(20, MaxY(_txtIMDBLink) + 20, WIDTH(self) - 40, 50);
        [_btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSave addTarget:self action:@selector(didTappedActorResumeSaveButton:) forControlEvents:UIControlEventTouchUpInside];
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

- (DMTextField *)txtLinkToReel {
    if (!_txtLinkToReel) {
        _txtLinkToReel = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_dottedView) + 20, WIDTH(self) - 20, 70) data:@{@"Icon":@"Link",@"Name":@"Link to Reel"}];
        _txtLinkToReel.txtField.delegate = self;
        _txtLinkToReel.txtField.tag = 1;
    }
    return _txtLinkToReel;
}

- (DMTextField *)txtIMDBLink {
    if (!_txtIMDBLink) {
        _txtIMDBLink = [[DMTextField alloc] initWithFrameTapButton:CGRectMake(10, MaxY(_txtLinkToReel) + 20, WIDTH(self) - 20, 70) data:@{@"Icon":@"Movie",@"Name":@"IMDB Link"}];
        _txtIMDBLink.txtField.delegate = self;
        _txtIMDBLink.txtField.tag = 2;
        
    }
    return _txtIMDBLink;
}

- (UIView *)OperationView {
    if (!_OperationView) {
        _OperationView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(_btnClick) + 40, WIDTH(_dottedView), 60)];
        [_OperationView addSubview:[self btnView]];
        [_OperationView addSubview:[self btnUpload]];
        [_OperationView addSubview:[self btnRemove]];
        
    }
    return _OperationView;
}

- (UIButton *)btnView {
    if (!_btnView) {
        _btnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnView.frame = CGRectMake(0, 0, WIDTH(_OperationView)/3, HEIGHT(_OperationView));
        [_btnView setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"View"] scaledToSize:CGSizeMake(WIDTH(_btnView), HEIGHT(_btnView))] forState:UIControlStateNormal];
        _btnView.tag = 1;
        [_btnView setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"View-Hover"] scaledToSize:CGSizeMake(WIDTH(_btnView), HEIGHT(_btnView))] forState:UIControlStateHighlighted];
        [_btnView addTarget:self action:@selector(didTappedOperationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //_btnView.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _btnView;
}

- (UIButton *)btnUpload {
    if (!_btnUpload) {
        _btnUpload = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUpload.frame = CGRectMake(MaxX(_btnView), 0, WIDTH(_OperationView)/3, HEIGHT(_OperationView));
        [_btnUpload setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"Upload"] scaledToSize:CGSizeMake(WIDTH(_btnUpload), HEIGHT(_btnUpload))] forState:UIControlStateNormal];
        [_btnUpload setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"Upload-Hover"] scaledToSize:CGSizeMake(WIDTH(_btnUpload), HEIGHT(_btnUpload))] forState:UIControlStateHighlighted];
        [_btnUpload addTarget:self action:@selector(didTappedOperationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnUpload.tag = 2;
        //_btnUpload.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _btnUpload;
}

- (UIButton *)btnRemove {
    if (!_btnRemove) {
        _btnRemove = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRemove.frame = CGRectMake(MaxX(_btnUpload), 0, WIDTH(_OperationView)/3, HEIGHT(_OperationView));
        [_btnRemove setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"RemoveCV"] scaledToSize:CGSizeMake(WIDTH(_btnUpload), HEIGHT(_btnUpload))] forState:UIControlStateNormal];
        [_btnRemove setImage:[[AppDelegate sharedDelegate] resizeImage:[UIImage imageNamed:@"RemoveCVH"] scaledToSize:CGSizeMake(WIDTH(_btnUpload), HEIGHT(_btnUpload))] forState:UIControlStateHighlighted];
        [_btnRemove addTarget:self action:@selector(didTappedOperationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRemove.tag = 3;
        //_btnRemove.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _btnRemove;
}

#pragma mark Continue Button Event
- (void)didTappedOperationButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didTappedActorResumeOperationButton:)]) {
        [self.delegate didTappedActorResumeOperationButton:sender];
    }
}

#pragma mark Save didTappedActorResumeSaveButton
- (void)didTappedActorResumeSaveButton:(UIButton *)sender {
    
    if ([AppDelegate sharedDelegate].strResumePath.length>0) {
        NSDictionary *dic = @{@"id":[AppDelegate sharedDelegate].strUserid,
                              @"linktoreel":_txtLinkToReel.txtField.text,
                              @"imdblink":_txtIMDBLink.txtField.text,
                              @"resume_description":@"",
                              };
        
        if ([_delegate respondsToSelector:@selector(didTappedActorResumeSaveButton:)]) {
            [_delegate didTappedActorResumeSaveButton:dic];
        }
    }else {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"Please upload Resume." delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil] show];
    }
    
    
}

-(void)addDashedBorder  {
    //border definitions
    CGFloat cornerRadius = 0;
    CGFloat borderWidth = 1;
    NSInteger dashPattern1 = 4;
    NSInteger dashPattern2 = 4;
    UIColor *lineColor = [UIColor grayColor];
    
    //drawing
    CGRect frame = _dottedView.bounds;
    
    CAShapeLayer *_shapeLayer = [CAShapeLayer layer];
    
    //creating a path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //drawing a border around a view
    CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
    CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
    CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
    CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
    CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    
    //path is set as the _shapeLayer object's path
    _shapeLayer.path = path;
    CGPathRelease(path);
    
    _shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
    _shapeLayer.frame = frame;
    _shapeLayer.masksToBounds = NO;
    [_shapeLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.strokeColor = [lineColor CGColor];
    _shapeLayer.lineWidth = borderWidth;
    _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:dashPattern1], [NSNumber numberWithInt:dashPattern2], nil];
    _shapeLayer.lineCap = kCALineCapRound;
    
    //_shapeLayer is added as a sublayer of the view, the border is visible
    [_dottedView.layer addSublayer:_shapeLayer];
    _dottedView.layer.cornerRadius = cornerRadius;
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.textColor = BaseColor;
   
    switch (textField.tag) {
        case 1: {
            _txtLinkToReel.hLine.backgroundColor = BaseColor;
        }
            break;
        case 2: {
            _txtIMDBLink.hLine.backgroundColor = BaseColor;
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
        case 1: {
            _txtLinkToReel.hLine.backgroundColor = GrayColor;
        }
            break;
        case 2: {
            _txtIMDBLink.hLine.backgroundColor = GrayColor;
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

- (void)updateResumeData{
    NSLog(@"updateResumeData");
    _txtIMDBLink.txtField.text = [AppDelegate sharedDelegate].strIMDBLink;
    _txtLinkToReel.txtField.text = [AppDelegate sharedDelegate].strLinkReel;
    if ([[AppDelegate sharedDelegate].strResumePath lastPathComponent].length == 0) {
        _lblCVName.text = NoResumeMessage;
        _btnView.enabled = false;
        _btnRemove.enabled = false;
        [AppDelegate sharedDelegate].strResumePath = @"";
        [AppDelegate sharedDelegate].fromDocument = false;
    }else {
        _btnView.enabled = true;
        _btnRemove.enabled = true;
        _lblCVName.text = [[AppDelegate sharedDelegate].strResumePath lastPathComponent];
    }
    
    
}

@end
