//
//  DMSideMenuCell.m
//  BoBL
//
//  Created by WTS on 30/09/15.
//  Copyright (c) 2015 WingsTechSolutions. All rights reserved.
//

#import "DMSideMenuCell.h"
#import "Macros.h"
#import "Themes.h"

@implementation DMSideMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:[self imgIcon]];
        [self addSubview:[self lblName]];
    }
    return self;
}

- (UIImageView *)imgIcon {
    if (!_imgIcon) {
        _imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 9, 48)];
        _imgIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgIcon;
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(_imgIcon) + 10, 12, WIDTH(self) - 40, HEIGHT(self) - 24)];
        _lblName.textColor = [UIColor lightGrayColor];
        _lblName.font = [UIFont systemFontOfSize:16.0];
    }
    return _lblName;
}

- (void)setData:(NSDictionary *)dic {
    _imgIcon.image =[UIImage imageNamed:[dic valueForKey:@"Icon"]];
    _lblName.text = [dic valueForKey:@"Name"];
}

@end
