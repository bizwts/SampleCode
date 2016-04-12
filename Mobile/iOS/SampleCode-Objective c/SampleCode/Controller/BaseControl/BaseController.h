//
//  BaseController.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 27/06/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//JALARAM TRAELS
//ABC

#import <UIKit/UIKit.h>
#import "FontAwesomeKit.h"
@interface BaseController : UIViewController

@property (nonatomic, assign) float topBarOffset;
@property (nonatomic, assign) float actionBarHeight;
@property (nonatomic, assign) float actionBarTopOffset;
@property (nonatomic, strong) FAKIcon *leftNavItemIcon;
@property (nonatomic, strong) NSString *leftNavItemTitle;
@property (nonatomic, strong) FAKIcon *rightNavItemIcon;
@property (nonatomic, strong) NSString *rightNavItemTitle;
@property (nonatomic, strong) UIImage *rightNavItemImage;
@property (nonatomic, assign) BOOL pushToNextNow;
@property (nonatomic, strong) UIView *backgroundView;

- (void)generalAppearanceSetup;

@end
