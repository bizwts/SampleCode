//
//  NSDate+KMKit.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 10/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMFloatingTextField+KMKit.h"
#import "TKRoundedView.h"
#import "Macros.h"
#import "UIColor+KMKit.h"
#import "Themes.h"

@implementation KMFloatingTextField (KMKit)

- (void)addLineView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(self) - 5, WIDTH(self) - 20, 2)];
    lineView.backgroundColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
    [self addSubview:lineView];
    
    TKRoundedView *circleView = [[TKRoundedView alloc] initWithFrame:CGRectMake(WIDTH(self) - 40, HEIGHT(self) - 10, 10, 10)];
    circleView.roundedCorners = TKRoundedCornerAll;
    circleView.cornerRadius = 5;
    circleView.borderColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
    circleView.fillColor = [UIColor colorFromHexCode:APP_PRIMARY_COLOR];
    [self addSubview:circleView];
}

- (void)addIcon:(UIImage *)icon {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (HEIGHT(self) - iconHeight)/2, iconHeight, iconHeight)];
    [iconView setImage:icon];
    [self addSubview:iconView];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 30, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 30, 0);
}

@end