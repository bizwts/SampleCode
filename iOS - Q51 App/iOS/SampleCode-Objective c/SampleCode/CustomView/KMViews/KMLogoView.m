//
//  KMLogoView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMLogoView.h"
#import "Macros.h"
#import "Constants.h"
#import "UIImageView+KMKit.h"

@interface KMLogoView ()

@property (nonatomic, strong) UIImageView *imgLogoView;
@property (nonatomic, strong) UILabel *lblLogoTitle;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property BOOL shouldDisplayTitle;
@property CGFloat factor;

@end

@implementation KMLogoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _factor = 0.6;
        _shouldDisplayTitle = YES;
        [self createLogoView];
    }
    return self;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
        [_backgroundImageView setContentMode:UIViewContentModeCenter];
    }
    return _backgroundImageView;
}

- (UIImageView *)imgLogoView {
    if (!_imgLogoView) {
        CGFloat logoHeight = HEIGHT(self) * _factor;
        CGSize logoSize = CGSizeMake(logoHeight, logoHeight);
        _imgLogoView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH(self) - logoSize.width)/2, (HEIGHT(self) - logoSize.height - (HEIGHT(self) * (1 - _factor))), logoSize.width, logoSize.height)];
        _imgLogoView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgLogoView;
}

- (UILabel *)lblLogoTitle {
    if (!_lblLogoTitle) {
        _lblLogoTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(_imgLogoView), WIDTH(self), (HEIGHT(self)*(1 - _factor)))];
        _lblLogoTitle.backgroundColor = [UIColor clearColor];
        _lblLogoTitle.textColor = self.titleTextColor;
        _lblLogoTitle.text = self.logoTitle;
        _lblLogoTitle.textAlignment = NSTextAlignmentCenter;
        _lblLogoTitle.font = [UIFont systemFontOfSize:APP_TITLE_SIZE];
    }
    return _lblLogoTitle;
}

- (void)layoutSubviews {
    CGFloat logoHeight = HEIGHT(self) * _factor;
    CGSize logoSize = CGSizeMake(logoHeight, logoHeight);
    _imgLogoView.frame = CGRectMake((WIDTH(self) - logoSize.width)/2, (HEIGHT(self) - logoSize.height - (HEIGHT(self) * (1 - _factor))), logoSize.width, logoSize.height);
    if (_shouldDisplayTitle)
        _lblLogoTitle.frame = CGRectMake(0, MaxY(_imgLogoView), WIDTH(self), (HEIGHT(self)*(1 - _factor)));
}

- (void)showLogoOnly {
    _factor = 0.8f;
    _shouldDisplayTitle = NO;
    [self layoutSubviews];
}

- (void)createLogoView {
    [self addSubview:[self backgroundImageView]];
    [self addSubview:[self imgLogoView]];
    [self addSubview:[self lblLogoTitle]];
}

- (void)setLogoImage:(UIImage *)logoImage {
    _logoImage = logoImage;
    [self imgLogoView].image = logoImage;
}

- (void)setLogoTitle:(NSString *)logoTitle {
    _logoTitle = logoTitle;
    [self lblLogoTitle].text = logoTitle;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    [self lblLogoTitle].textColor = titleTextColor;
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    _attributedTitle = attributedTitle;
    [self lblLogoTitle].attributedText = _attributedTitle;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    [self backgroundImageView].image = backgroundImage;
}

- (void)blurBackgroundWithRadius:(CGFloat)radius {
    if (!_backgroundImage) return;
    [[self backgroundImageView] setImageToBlur:_backgroundImage blurRadius:radius completionBlock:nil];
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
