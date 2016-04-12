//
//  UpdateActorHeadShotView.h
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macros.h"
#import "Themes.h"
#import "UIImage+KMKit.h"
#import "AppDelegate.h"
#import "DMCustButton.h"
#import "Constants.h"

@protocol UpdateActorHeadShotDelegate <NSObject>

@optional

- (void)didTappedClickPlusButton:(UIButton *)sender;

@end

@interface UpdateActorHeadShotView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) id<UpdateActorHeadShotDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *btnFirstHeadShot;
@property (nonatomic, strong) UIButton *btnAddHeadShot;
@property (nonatomic, strong) UIButton *btnViewAll;

@property (nonatomic, strong) UIButton *btnPlus;

@end
