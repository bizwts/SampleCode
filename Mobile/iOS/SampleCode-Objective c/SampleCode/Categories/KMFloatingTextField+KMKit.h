//
//  NSDate+KMKit.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 10/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMFloatingTextField.h"

#define iconHeight 32

@interface KMFloatingTextField (KMKit)

- (void)addLineView;
- (void)addIcon:(UIImage *)icon;
@end
