//
//  BaseViewController.m
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 08/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "UIImage+KMKit.h"

@implementation UINavigationBar (KMKit)

- (void)configureNavigationBarWithColor:(UIColor *)color
{
    [self setBackgroundImage:[UIImage imageWithColor:color cornerRadius:0]
               forBarMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
    NSMutableDictionary *titleTextAttributes = [[self titleTextAttributes] mutableCopy];
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionary];
    }
    
    if (&NSShadowAttributeName != NULL) {
        // iOS6 methods
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowOffset:CGSizeZero];
        [shadow setShadowColor:[UIColor clearColor]];
        [titleTextAttributes setObject:shadow forKey:NSShadowAttributeName];
        [titleTextAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    } else {
        // Pre-iOS6 methods
//        [titleTextAttributes setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
//        [titleTextAttributes setValue:[NSValue valueWithUIOffset:UIOffsetZero] forKey:UITextAttributeTextShadowOffset];
    }
    
    [self setTitleTextAttributes:titleTextAttributes];
    
    if ([self respondsToSelector:@selector(setShadowImage:)]) {
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]];
    }
}

@end