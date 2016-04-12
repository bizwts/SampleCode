//
//  UpdateActorBasicDetailsView.h
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

@protocol UpdateActorBasicDetailsViewDelegate <NSObject>

@optional

-(void)didTappedActorBasicDetailSaveButton:(NSMutableDictionary *)dic;

@end

@interface UpdateActorBasicDetailsView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) id<UpdateActorBasicDetailsViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DMTextField *txtEmailId;
@property (nonatomic, strong) DMTextField *txtFirstName;
@property (nonatomic, strong) DMTextField *txtMiddleName;
@property (nonatomic, strong) DMTextField *txtLastName;
@property (nonatomic, strong) DMTextField *txtContactNo;

//@property (nonatomic, strong) DMTitleView *ttlCityState;
@property (nonatomic, strong) DMTextField *txtCity;
@property (nonatomic, strong) DMTextField *txtState;

@property (nonatomic, strong) UIButton *btnSave;
@end
