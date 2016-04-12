//
//  UIView+KMKit.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 17/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KMKit)

- (NSArray*) allSubviews;
- (void)addSubviewWithBounce:(UIView *)theView;

@end
