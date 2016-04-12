//
//  DMButton.h
//  SignMe
//
//  Created by WTS on 09/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMButton : UIView

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)data;



@end
