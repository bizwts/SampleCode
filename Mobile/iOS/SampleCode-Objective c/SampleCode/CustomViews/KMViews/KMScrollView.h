//
//  KMScrollView.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollContainer;


- (void)configure;
- (void)addView:(UIView *)view;
- (void)addViewsFromArray:(NSArray *)views;
- (void)setScrollContentSize:(CGSize)size;
- (void)setArrowView:(BOOL)needArrow withHeight:(CGFloat)height;

@end
