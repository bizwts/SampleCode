//
//  UIButton+KMBlock.h
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 09/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUIButtonBlockTouchUpInside @"TouchInside"
#define kUIButtonBlockTouchDown @"TouchDown"

@interface UIButton (KMBlock)

@property (nonatomic, strong) NSMutableDictionary *actions;

- (void) setAction:(NSString*)action withBlock:(void(^)())block;

@end
