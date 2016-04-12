//
//  UpdateActorBioDetailView.h
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"
#import "DMTextField.h"
#import "Themes.h"
#import "UIImage+KMKit.h"
#import "DMTitleView.h"
#import "DMCheckBox.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "SVProgressHUD.h"

@protocol UpdateActorBioDetailViewDelegate <NSObject>

@optional

-(void)didTappedActorBioDetailSaveButton:(NSMutableDictionary *)dic;

@end

@interface UpdateActorBioDetailView : UIView<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) id<UpdateActorBioDetailViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DMTitleView *ttlGender;
@property (nonatomic, strong) DMCheckBox *chkMale;
@property (nonatomic, strong) DMCheckBox *chkFemale;
@property (nonatomic, strong) DMCheckBox *chkTransgender;

@property (nonatomic, strong) DMTitleView *ttlAgeRange;
@property (nonatomic, strong) DMTextField *txtAgeRangeFrom;
@property (nonatomic, strong) DMTextField *txtAgeRangeTo;

@property NSString *strGender;

@property (nonatomic, strong) DMTitleView *ttlRace;
@property (nonatomic, strong) DMTextField *txtRace;

@property (nonatomic, strong) DMTitleView *ttlAge;

@property (nonatomic, strong) DMTitleView *ttlUnion;
@property (nonatomic, strong) DMTextField *txtUnion;

@property (nonatomic, strong) UIPickerView *pickerData, *pickerDataMultiPleColumn;
@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) NSMutableArray *aryData;
@property (nonatomic, strong) NSString *pickerText;

@property (strong, nonatomic) NSArray *aryFirstLetter;
@property (strong, nonatomic) NSArray *arySecondLetter;
@property (strong, nonatomic) NSString *first,*second;

@property (nonatomic, strong) UIButton *btnSave;

@end
