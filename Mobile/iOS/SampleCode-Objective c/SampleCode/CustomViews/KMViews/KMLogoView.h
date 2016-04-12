//
//  KMLogoView.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMLogoView : UIView

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) NSString *logoTitle;
@property (nonatomic, strong) UIImage *logoImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSAttributedString *attributedTitle;

- (void)blurBackgroundWithRadius:(CGFloat)radius;
- (void)showLogoOnly;

@end
