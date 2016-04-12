//
//  KMFloatingTextField.h
//  Templates
//
//  Created by KETAN MODHA on 10/02/14.
//  Copyright (c) 2014 KETAN MODHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterFieldCell;

@interface KMFloatingTextField : UITextField

@property (nonatomic, strong, readonly) UILabel * floatingLabel;
@property (nonatomic, strong) NSNumber * floatingLabelYPadding UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont * floatingLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor * floatingLabelTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor * floatingLabelActiveTextColor UI_APPEARANCE_SELECTOR; // tint color is used by default if not provided
@property (nonatomic, assign) NSInteger animateEvenIfNotFirstResponder UI_APPEARANCE_SELECTOR; // Can't use BOOL for UI_APPEARANCE. Non-zero == YES
@property (nonatomic, strong) UIColor * placeholderTextColor UI_APPEARANCE_SELECTOR;
//@property (nonatomic, strong) RegisterFieldCell *cell;

- (void)addBorders;
- (void)hideBorders;

@end
