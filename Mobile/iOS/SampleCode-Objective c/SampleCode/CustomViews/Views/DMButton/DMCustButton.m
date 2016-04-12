//
//  DMCustButton.m
//  SignMe
//
//  Created by WTS on 16/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "DMCustButton.h"
#import "Macros.h"
#import "Themes.h"

@implementation DMCustButton

- (id)initWithDiffFrame:(CGRect)frame dic:(NSDictionary *)data {
    self = [super initWithFrame:frame];
    if (self) {
        _imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (HEIGHT(self) - 20) / 2, 20, 20)];
        _imgIcon.image = [UIImage imageNamed:[data valueForKey:@"Icon"]];
        _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgIcon];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_imgIcon) + 5, 0, WIDTH(self) - 10, HEIGHT(self))];
        _lblTitle.text = [data valueForKey:@"Name"];
        _lblTitle.font = [UIFont systemFontOfSize:14.0f];
        _lblTitle.textColor = BaseColor;
        [self addSubview:_lblTitle];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)data {
    self = [super initWithFrame:frame];
    if (self) {
        _imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH(self) - (HEIGHT(self) - 25) ) / 2, 5, HEIGHT(self) - 25, HEIGHT(self) - 25)];
        _imgIcon.image = [UIImage imageNamed:[data valueForKey:@"Icon"]];
        _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgIcon];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(_imgIcon) + 5, WIDTH(self), 15)];
        _lblTitle.text = [data valueForKey:@"Name"];
        _lblTitle.font = [UIFont systemFontOfSize:12.0f];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = [UIColor whiteColor];
        [self addSubview:_lblTitle];
    }
    return self;
}

@end
