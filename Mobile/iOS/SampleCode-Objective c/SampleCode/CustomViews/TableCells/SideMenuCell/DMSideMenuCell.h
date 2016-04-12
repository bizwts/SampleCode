//
//  DMSideMenuCell.h
//  BoBL
//
//  Created by WTS on 30/09/15.
//  Copyright (c) 2015 WingsTechSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMSideMenuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblName;

- (void)setData:(NSDictionary *)dic;

@end
