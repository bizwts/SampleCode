//
//  KMButton.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMButton.h"
#import "Themes.h"
#import "UIColor+KMKit.h"
#import "UIImage+KMKit.h"

@implementation KMButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:4.0f] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR] cornerRadius:4.0f] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR] cornerRadius:4.0f] forState:UIControlStateSelected];
        
        [self setTitleShadowColor:[UIColor colorFromHexCode:APP_THEME_COLOR_ONE] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor colorFromHexCode:APP_THEME_COLOR_ONE] forState:UIControlStateHighlighted];
        [self setTitle:@"Log In" forState:UIControlStateNormal];
        [self setTitle:@"Log In" forState:UIControlStateHighlighted];

        [self setTitleColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] forState:UIControlStateSelected];
        
        [self.titleLabel setFont:[UIFont fontWithName:@"Bell MT" size:18.0f]];
//        [self.layer setShadowColor:[UIColor colorFromHexCode:APP_THEME_COLOR_ONE].CGColor];
//        [self.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
//        [self.layer setShadowOpacity:1];
        [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.layer.cornerRadius = 4.0f;
    }
    return self;
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    [self setTitle:buttonTitle forState:UIControlStateNormal];
    [self setTitle:buttonTitle forState:UIControlStateHighlighted];
    [self setTitle:buttonTitle forState:UIControlStateSelected];
}

- (void)buttonTapped:(id)sender {
    if (_actionBlock) {
        _actionBlock(self);
    }
}

- (void)invertBackgroundImage {
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR] cornerRadius:4.0f] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] cornerRadius:4.0f] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorFromHexCode:APP_SECONDARY_COLOR] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorFromHexCode:APP_PRIMARY_COLOR] forState:UIControlStateHighlighted];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
