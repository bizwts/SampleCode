//
//  KMScrollView.m
//  Test
//
//  Created by Wingstech Solutions Pvt. Ltd. on 15/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//http://install.diawi.com/h8atsR
//http://install.diawi.com/jPYphK

#import "KMScrollView.h"
#import "Macros.h"

@interface KMScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *downArrowView;
@property (nonatomic) BOOL needDownArrow;

@end

@implementation KMScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self scrollContainer]];
        [self configure];
        [self addSubview:[self downArrowView]];
    }
    return self;
}

- (void)setArrowView:(BOOL)needArrow withHeight:(CGFloat)height
{
    _downArrowView.frame = CGRectMake(0, height-10, WIDTH(self), 10);
    _downArrowView.hidden=needArrow?NO:YES;
    _needDownArrow = needArrow;
}

- (void)configure {
    
}
- (UIView *) downArrowView
{
    if (!_downArrowView) {
        _downArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 340, WIDTH(self), 10)];
        
        UIImageView *imgDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake((MaxX(self)/2)-5, 0, 10, 10)];
        [_downArrowView addSubview:imgDownArrow];
        imgDownArrow.image = [UIImage imageNamed:@"Down-arrow.png"];
        _downArrowView.hidden = YES;
    }
    return _downArrowView;
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

- (void)addView:(UIView *)view {
    [_scrollContainer addSubview:view];
}

- (void)addViewsFromArray:(NSArray *)views {
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_scrollContainer addSubview:obj];
    }];
}
- (void)setScrollContentSize:(CGSize)size {
    [_scrollContainer setContentSize:size];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_needDownArrow)
    {
        if (scrollView.contentOffset.y < 10) {
            _downArrowView.hidden = NO;
        }
        else if (scrollView.contentOffset.y >= 10) {
            _downArrowView.hidden = YES;
        }
    }
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
