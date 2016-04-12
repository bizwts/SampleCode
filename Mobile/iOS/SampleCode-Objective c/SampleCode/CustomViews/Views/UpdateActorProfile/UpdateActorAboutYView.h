//
//  UpdateActorAboutYView.h
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMTitleView.h"
#import "TTRangeSlider.h"
#import "DMTextField.h"
#import "DMLabel.h"
#import "UIImage+KMKit.h"
#import "DMCheckBox.h"
#import "Macros.h"
#import "Constants.h"
#import "Themes.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "SHMultipleSelect.h"
@protocol UpdateActorAboutViewDelegate <NSObject>

@optional
-(void)didTappedActorAboutYouSaveButton:(NSMutableDictionary *)dic;

@end

@interface UpdateActorAboutYView : UIView<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate, SHMultipleSelectDelegate>

@property (nonatomic, strong) id<UpdateActorAboutViewDelegate> delegate;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DMTitleView *ttlCredit;
@property (nonatomic, strong) DMTextField *txtCredit;

@property (nonatomic, strong) DMTitleView *ttlBestSkill;
@property (nonatomic, strong) DMTextField *txtSkil;

@property (nonatomic, strong) DMTitleView *ttlUnique;
@property (nonatomic, strong) DMTextField *txtUnique;

@property (nonatomic, strong) DMTitleView *ttlTraining;
@property (nonatomic, strong) DMCheckBox *chkTrainingYes;
@property (nonatomic, strong) DMCheckBox *chkTrainingNo;
@property (nonatomic, strong) DMCheckBox *chkTrainingBoth;
@property NSString *strTraining;


@property (nonatomic, strong) DMTitleView *ttlSeeking;
@property (nonatomic, strong) DMCheckBox *chkSeekingManager;
@property (nonatomic, strong) DMCheckBox *chkSeekingAgent;
@property (nonatomic, strong) DMCheckBox *chkSeekingBoth;
@property NSString *strSeeking;

@property (nonatomic, strong) DMTitleView *ttlTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkCommercialTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkTheatricalTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkModelTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkComedyTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkRealityTVTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkVoiceOverTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkBackgroundTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkMusicalArtistTypeOfWork;
@property (nonatomic, strong) DMCheckBox *chkDancerTypeOfWork;
@property NSString *strTypeOfWork;

@property (nonatomic, strong) DMTitleView *ttlSigned;
@property (nonatomic, strong) DMCheckBox *chkSignedYes;
@property (nonatomic, strong) DMCheckBox *chkSignedNo;
@property NSString *strSigned;

@property (nonatomic, strong) DMTitleView *ttlRepresentation;
@property (nonatomic, strong) DMTextField *txtRepresentation;

@property (nonatomic, strong) DMTitleView *ttlPassport;
@property (nonatomic, strong) DMCheckBox *chkPassportYes;
@property (nonatomic, strong) DMCheckBox *chkPassportNo;
@property NSString *strPassport;
@property (nonatomic, strong) DMTextField *txtStartDate;
@property (nonatomic, strong) DMTextField *txtEndDate;
@property (nonatomic, strong) UIView *vPassportLine;

@property (nonatomic, strong) UIPickerView *pickerData, *pickerDataMultiPleColumn;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (strong, nonatomic) NSArray *aryFirstLetter;
@property (strong, nonatomic) NSArray *arySecondLetter, *aryThirdLetter;
@property (strong, nonatomic) NSString *first,*second,*third;
@property NSInteger pickerComponent;
@property NSString *selectedDate;

@property (nonatomic, strong) NSMutableArray *aryData;
@property (nonatomic, strong) NSString *pickerText;

@property (nonatomic, strong) NSMutableArray *aryTypeOfWork;

@end
