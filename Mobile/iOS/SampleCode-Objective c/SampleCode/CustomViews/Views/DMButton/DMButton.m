//
//  DMButton.m
//  SignMe
//
//  Created by WTS on 09/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "DMButton.h"
#import "Macros.h"
#import "Themes.h"
@implementation DMButton

- (id)initWithFrame:(CGRect)frame dic:(NSDictionary *)data {
    self = [super initWithFrame:frame];
    if (self) {
        _imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, HEIGHT(self), HEIGHT(self) - 20)];
        _imgIcon.image = [UIImage imageNamed:[data valueForKey:@"Icon"]];
        //_imgIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgIcon];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_imgIcon) + 10, 0, WIDTH(self) - MaxX(_imgIcon) - 20, HEIGHT(self))];
        _lblTitle.text = [data valueForKey:@"Name"];
        _lblTitle.font = [UIFont systemFontOfSize:14.0f];
        _lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _lblTitle.numberOfLines = 3;
        _lblTitle.textColor = BaseColor;
        [self addSubview:_lblTitle];
    }
    return self;
}

@end
