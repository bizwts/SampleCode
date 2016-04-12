//
//  KMButton.h
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMButton;

typedef void (^ActionBlock)(KMButton *);

@interface KMButton : UIButton

@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) ActionBlock actionBlock;

- (void)setButtonTitle:(NSString *)buttonTitle;
- (void)invertBackgroundImage;

@end