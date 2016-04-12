//
//  UpdateActorResumeView.h
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Macros.h"
#import "Themes.h"
#import "YCameraViewController.h"
#import "UIImage+KMKit.h"
#import "DMTextField.h"
#import "PNTToolbar.h"
#import "AppDelegate.h"
#import "Constants.h"
@protocol UpdateActorResumeViewDelegate <NSObject>

@optional

-(void)didTappedActorResumeSaveButton:(NSDictionary *)dic;
-(void)didTappedActorResumeOperationButton:(UIButton *)sender;

@end

@interface UpdateActorResumeView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) id<UpdateActorResumeViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *btnClick;
@property (nonatomic, strong) UILabel *lblCVName;
@property (nonatomic, strong) UIButton *btnSave;

@property (nonatomic, strong) UIView *OperationView;
@property (nonatomic, strong) UIButton *btnView;
@property (nonatomic, strong) UIButton *btnUpload;
@property (nonatomic, strong) UIButton *btnRemove;

@property (nonatomic, strong) DMTextField *txtLinkToReel;
@property (nonatomic, strong) DMTextField *txtIMDBLink;

@property (nonatomic, strong) UIView *dottedView;

@end

