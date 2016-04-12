//
//  UIScrollView+KMKit.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 07/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (KMKit)

-(void)km_ScrollRectToVisibleCenteredOn:(CGRect)visibleRect
                               animated:(BOOL)animated;

@end
