//
//  DMCustButton.h
//  SignMe
//
//  Created by WTS on 16/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCustButton : UIButton

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

//Icon\n Label
- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)data;

//Icon + Label
- (id)initWithDiffFrame:(CGRect)frame dic:(NSDictionary *)data;

@end
