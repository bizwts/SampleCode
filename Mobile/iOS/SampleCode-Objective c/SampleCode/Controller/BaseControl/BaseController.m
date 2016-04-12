//
//  BaseController.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 27/06/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "BaseController.h"
#import "Macros.h"
#import "Constants.h"
#import "Themes.h"
#import "UIColor+KMKit.h"
#import "UINavigationBar+KMKit.h"

@interface BaseController ()

@end

@implementation BaseController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil    {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.topBarOffset = isIOS7 ? kStatusBarHeight + kTopBarHeight : 0;
        self.actionBarHeight = isiPhone5 ? 60 : 50;
        self.actionBarTopOffset = isIOS7 ? 0 : kTopBarHeight;
    }
    return self;
}

- (void)viewDidLoad     {
    [super viewDidLoad];
    
    self.title = APP_NAME;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0f]};
    
    _backgroundView = [[UIView alloc] initWithFrame:Rect(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    _backgroundView.backgroundColor = [UIColor colorFromHexCode:APP_BACKGROUND_COLOR];
    [self.view addSubview:_backgroundView];

    [self generalAppearanceSetup];
}

- (void)leftNavItemClick {
}

- (void)rightNavItemClick {
}

- (void)generalAppearanceSetup  {
    self.view.backgroundColor = BaseColor;
    if (self.navigationController) {
        [self.navigationController.navigationBar configureNavigationBarWithColor:NavigationColor];
        CGFloat navItemMargin = isIOS7 ? 16 : 0;
        
        if (self.leftNavItemIcon || self.leftNavItemTitle) {
            UIButton *leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [leftItemButton addTarget:self action:@selector(leftNavItemClick) forControlEvents:UIControlEventTouchUpInside];
            if (self.leftNavItemIcon && self.leftNavItemTitle) {
                [self.leftNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *leftItemImage = [self.leftNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [leftItemButton setImage:leftItemImage forState:UIControlStateNormal];
                
                [self.leftNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *leftItemHighlightImage = [self.leftNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [leftItemButton setImage:leftItemHighlightImage forState:UIControlStateHighlighted];
                
                CGSize fontSize = [self.leftNavItemTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE]}];
                leftItemButton.frame = CGRectMake(0, 0, fontSize.width + kTopBarHeight, kTopBarHeight);
                
                leftItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                leftItemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                leftItemButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
                leftItemButton.titleLabel.font = [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE];
                [leftItemButton setTitle:self.leftNavItemTitle forState:UIControlStateNormal];
                [leftItemButton setTitleColor:NavigationColor forState:UIControlStateNormal];
                [leftItemButton setTitleColor:NavigationColor forState:UIControlStateHighlighted];
            }
            else if (self.leftNavItemIcon) {
                leftItemButton.frame = CGRectMake(0, 0, kTopBarHeight, kTopBarHeight);
                
                [self.leftNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *leftItemImage = [self.leftNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [leftItemButton setBackgroundImage:leftItemImage forState:UIControlStateNormal];
                
                [self.leftNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *leftItemHighlightImage = [self.leftNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [leftItemButton setBackgroundImage:leftItemHighlightImage forState:UIControlStateHighlighted];
            } else {
                CGSize fontSize = [self.leftNavItemTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE]}];
                leftItemButton.frame = CGRectMake(0, 0, fontSize.width + 20, kTopBarHeight);
                leftItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                leftItemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                leftItemButton.titleLabel.font = [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE];
                [leftItemButton setTitle:self.leftNavItemTitle forState:UIControlStateNormal];
                [leftItemButton setTitleColor:NavigationColor forState:UIControlStateNormal];
                [leftItemButton setTitleColor:NavigationColor forState:UIControlStateHighlighted];
            }
            
            UIView *leftItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(leftItemButton), HEIGHT(leftItemButton))];
            [leftItemView addSubview:leftItemButton];
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItemView];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:-navItemMargin];
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, self.navigationItem.leftBarButtonItem, nil];
        }
        else {
            self.navigationItem.leftBarButtonItems = nil;
        }
        
        if (self.rightNavItemIcon || self.rightNavItemTitle) {
            UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [rightItemButton addTarget:self action:@selector(rightNavItemClick) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.rightNavItemIcon) {
                rightItemButton.frame = CGRectMake(0, 0, kTopBarHeight, kTopBarHeight);
                
                [self.rightNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *rightItemImage = [self.rightNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [rightItemButton setBackgroundImage:rightItemImage forState:UIControlStateNormal];
                
                [self.rightNavItemIcon addAttribute:NSForegroundColorAttributeName value:NavigationColor];
                UIImage *rightItemHighlightImage = [self.rightNavItemIcon imageWithSize:CGSizeMake(kTopBarHeight, kTopBarHeight)];
                [rightItemButton setBackgroundImage:rightItemHighlightImage forState:UIControlStateHighlighted];
            } else {
                CGSize fontSize = [self.rightNavItemTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE]}];
                rightItemButton.frame = CGRectMake(0, 0, fontSize.width + 20, kTopBarHeight);
                rightItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                rightItemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
                rightItemButton.titleLabel.font = [UIFont boldSystemFontOfSize:NAV_BAR_ITEM_FONT_SIZE];
                [rightItemButton setTitle:self.rightNavItemTitle forState:UIControlStateNormal];
                [rightItemButton setTitleColor:NavigationColor forState:UIControlStateNormal];
                [rightItemButton setTitleColor:NavigationColor forState:UIControlStateHighlighted];
            }
            
            UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(rightItemButton), HEIGHT(rightItemButton))];
            [rightItemView addSubview:rightItemButton];
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:-navItemMargin];
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, self.navigationItem.rightBarButtonItem, nil];
        }
        
        if (self.rightNavItemImage) {
            UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [rightItemButton addTarget:self action:@selector(rightNavItemClick) forControlEvents:UIControlEventTouchUpInside];
            rightItemButton.frame = CGRectMake(0, 0, kTopBarHeight, kTopBarHeight);
            
            [rightItemButton setBackgroundImage:self.rightNavItemImage forState:UIControlStateNormal];
            
            UIView *rightItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(rightItemButton), HEIGHT(rightItemButton))];
            [rightItemView addSubview:rightItemButton];
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [negativeSpacer setWidth:-navItemMargin];
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, self.navigationItem.rightBarButtonItem, nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end