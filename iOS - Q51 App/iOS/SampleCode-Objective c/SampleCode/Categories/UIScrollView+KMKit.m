//
//  UIScrollView+KMKit.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 07/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "UIScrollView+KMKit.h"

@implementation UIScrollView (KMKit)

-(void)km_ScrollRectToVisibleCenteredOn:(CGRect)visibleRect
                              animated:(BOOL)animated
{
    
    CGPoint center = visibleRect.origin;
    center.x += visibleRect.size.width/2;
    center.y += visibleRect.size.height/2;
    
    center.x *= self.zoomScale;
    center.y *= self.zoomScale;
    
    
    CGRect centeredRect = CGRectMake(center.x - self.frame.size.width/2.0,
                                     center.y - self.frame.size.height/2.0,
                                     self.frame.size.width,
                                     self.frame.size.height);
    [self scrollRectToVisible:centeredRect
                     animated:animated];
}


@end
