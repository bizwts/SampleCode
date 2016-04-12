//
//  UIView+KMKit.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 17/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "UIView+KMKit.h"

@implementation UIView (KMKit)

- (NSArray*) allSubviews {
    __block NSArray* allSubviews = [NSArray arrayWithObject:self];
    
    [self.subviews enumerateObjectsUsingBlock:^( UIView* view, NSUInteger idx, BOOL*stop) {
        allSubviews = [allSubviews arrayByAddingObjectsFromArray:[view allSubviews]];
    }];
    return allSubviews;
}

-(void)addSubviewWithBounce:(UIView *)theView
{
    theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self addSubview:theView];
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            theView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                theView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

@end
