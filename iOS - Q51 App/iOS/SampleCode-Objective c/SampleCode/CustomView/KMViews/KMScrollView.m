//
//  KMScrollView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "KMScrollView.h"

@interface KMScrollView () <UIScrollViewDelegate>

@end

@implementation KMScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:[self scrollContainer]];
        [self configure];
    }
    return self;
}

- (void)configure {
    
}

- (UIScrollView *)scrollContainer {
    if (!_scrollContainer) {
        _scrollContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollContainer.delegate = self;
        _scrollContainer.scrollsToTop = YES;
    }
    return _scrollContainer;
}

- (UIScrollView *)containerView {
    return _scrollContainer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
