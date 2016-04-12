//
//  UpdateActorAppearanceView.h
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
#import "Constants.h"
#import "SHMultipleSelect.h"
@protocol UpdateActorAppearanceViewDelegate <NSObject>

@optional

-(void)didTappedActorAppearanceSaveButton:(NSMutableDictionary *)dic;

@end

@interface UpdateActorAppearanceView : UIView<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate, SHMultipleSelectDelegate>

@property (nonatomic, strong) id<UpdateActorAppearanceViewDelegate> delegate;
@property (nonatomic, strong) UIButton *btnSave;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DMTitleView *ttlHeight;
@property (nonatomic, strong) DMTextField *txtHeightFeet;
@property (nonatomic, strong) DMTextField *txtHeightInches;

@property (nonatomic, strong) DMTitleView *ttlWeight;
@property (nonatomic, strong) DMTextField *txtWeight;

@property (nonatomic, strong) DMTitleView *ttlHairColor;
@property (nonatomic, strong) DMTextField *txtHairColor;

@property (nonatomic, strong) DMTitleView *ttlHairLength;
@property (nonatomic, strong) DMTextField *txtHairLength;

@property (nonatomic, strong) DMTitleView *ttlEyeColor;
@property (nonatomic, strong) DMTextField *txtEyeColor;

@property (nonatomic, strong) DMTitleView *ttlBodyType;
@property (nonatomic, strong) DMTextField *txtBodyType;

@property (nonatomic, strong) DMTitleView *ttlCupSize;
@property (nonatomic, strong) DMTextField *txtCupSize;

@property (nonatomic, strong) DMTitleView *ttlBustSize;
@property (nonatomic, strong) DMTextField *txtBustSize;

@property (nonatomic, strong) DMTitleView *ttlFacial;
@property (nonatomic, strong) DMLabel *lblFacialHair;
@property (nonatomic, strong) DMCheckBox *chkFacialHairYes;
@property (nonatomic, strong) DMCheckBox *chkFacialHairNo;
@property NSString *strFacialHair;

@property (nonatomic, strong) DMLabel *lblBodyHair;
@property (nonatomic, strong) DMCheckBox *chkBodyHairYes;
@property (nonatomic, strong) DMCheckBox *chkBodyHairNo;
@property NSString *strBodyHair;

@property (nonatomic, strong) UIView *appearanceGenderView;

@property (nonatomic, strong) DMLabel *lblTatoo;
@property (nonatomic, strong) DMCheckBox *chkTatooYes;
@property (nonatomic, strong) DMCheckBox *chkTatooNo;
@property NSString *strTatoo;

@property (nonatomic, strong) DMLabel *lblTatooVisible;
@property (nonatomic, strong) DMCheckBox *chkTatooVisibleYes;
@property (nonatomic, strong) DMCheckBox *chkTatooVisibleNo;
@property NSString *strTatooVisible;

@property (nonatomic, strong) DMLabel *lblPiercing;
@property (nonatomic, strong) DMCheckBox *chkPiercingYes;
@property (nonatomic, strong) DMCheckBox *chkPiercingNo;
@property NSString *strPiercing;

@property (nonatomic, strong) DMLabel *lblPiercingVisible;
@property (nonatomic, strong) DMCheckBox *chkPiercingVisibleYes;
@property (nonatomic, strong) DMCheckBox *chkPiercingVisibleNo;
@property NSString *strPiercingVisible;

@property (nonatomic, strong) DMTextField *txtHatSize;

@property (nonatomic, strong) DMTextField *txtGloveSize;

@property (nonatomic, strong) DMTextField *txtShoeSize;

@property (nonatomic, strong) DMLabel *lblWaistSize;
@property (nonatomic, strong) DMTextField *txtWaistSize;

@property (nonatomic, strong) DMTextField *txtShirtSize;

@property (nonatomic, strong) DMTextField *txtCoatSize;

@property (nonatomic, strong) DMLabel *lblChestSize;
@property (nonatomic, strong) DMTextField *txtChestSize;

@property (nonatomic, strong) DMTextField *txtInSeam;

@property (nonatomic, strong) DMTextField *txtGlasses;

@property (nonatomic, strong) DMTextField *txtSpecialCharacteristic;

@property (nonatomic, strong) DMTextField *txtAssistiveDevices;

@property (nonatomic, strong) UIPickerView *pickerData, *pickerDataMultiPleColumn;
@property (nonatomic, strong) UIToolbar *toolBar;

@property (strong, nonatomic) NSArray *aryFirstLetter, *aryWeightFirstLetter;
@property (strong, nonatomic) NSArray *arySecondLetter, *aryThirdLetter;
@property (strong, nonatomic) NSString *first,*second,*third;
@property NSInteger pickerComponent;

@property (nonatomic, strong) NSMutableArray *aryData;
@property (nonatomic, strong) NSString *pickerText;

@end
