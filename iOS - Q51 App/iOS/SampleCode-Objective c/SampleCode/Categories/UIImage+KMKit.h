//
//  BaseViewController.h
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 08/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KMKit)

+ (UIImage *)imageFromView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *) buttonImageWithColor:(UIColor *)color
                      cornerRadius:(CGFloat)cornerRadius
                       shadowColor:(UIColor *)shadowColor
                      shadowInsets:(UIEdgeInsets)shadowInsets;

+ (UIImage *) circularImageWithColor:(UIColor *)color
                                size:(CGSize)size;

- (UIImage *) imageWithMinimumSize:(CGSize)size;

+ (UIImage *) stepperPlusImageWithColor:(UIColor *)color;

+ (UIImage *) stepperMinusImageWithColor:(UIColor *)color;

+ (UIImage *) backButtonImageWithColor:(UIColor *)color
                            barMetrics:(UIBarMetrics) metrics
                          cornerRadius:(CGFloat)cornerRadius;

- (UIImage *)cropImage:(CGRect)rect;

- (UIImage *)applyBlurWithImage:(UIImage *)theImage;

- (UIImage *)applyLightEffect;

- (UIImage *)applyExtraLightEffect;

- (UIImage *)applyDarkEffect;

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

+ (UIImage*)drawText:(NSString*)text inImage:(UIImage*)image atPoint:(CGPoint)point;

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds;
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
- (UIImage *)scaleImage:(UIImage *)image proportionallyToSize:(CGSize)newSize;

- (UIImage *)vImageScaledImageWithSize:(CGSize)destSize contentMode:(UIViewContentMode)contentMode;
- (UIImage *)vImageScaledImageWithSize:(CGSize)destSize;

@end

