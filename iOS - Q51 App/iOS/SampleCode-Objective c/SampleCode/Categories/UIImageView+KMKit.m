//
//  UIImageView+KMKit.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 11/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "UIImageView+KMKit.h"
#import "UIImage+KMKit.h"
#import "AFNetworking.h"
#import "Util.h"

CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 5.0;

@implementation UIImageView (KMKit)

#pragma mark - LBBlurredImage Additions

- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion
{
    [self setImageToBlur:image
              blurRadius:kLBBlurredImageDefaultBlurRadius
         completionBlock:completion];
}

- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kLBBlurredImageDefaultSaturationDeltaFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if(completion) {
                completion();
            }
        });
    });
}

- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
            saturation:(CGFloat)factor
       completionBlock:(LBBlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:factor
                                                 maskImage:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if(completion) {
                completion();
            }
        });
    });
}

@end
