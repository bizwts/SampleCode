//
//  ALScrollViewPaging.m
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import "ALScrollViewPaging.h"
#import "Themes.h"


@interface ALScrollViewPaging()

@end

@implementation ALScrollViewPaging

const int kDotWidth = 7;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //setting the 'must have' properties
        [self setBackgroundColor:[UIColor clearColor]];
        self.pagingEnabled = YES;
        self.delegate = self;
        self.maximumZoomScale = 3.0f;
        pageControlBeingUsed = NO;
        self.bounces = NO;
        _pageControl = [[DDPageControl alloc]initWithType:DDPageControlTypeOnEmptyOffFull];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        //add pages to scrollview
        [self addPages:pages];
        
    }
    return self;
}

#pragma mark - Setter

//setter for hasPageControl property
//if is YES, we can create the page control and place it under the scrollview
- (void)setHasPageControl:(BOOL)hasPageControl {
    _hasPageControl = hasPageControl;
    //if hasPageControl is true
    if (hasPageControl) {
        //set number of page based on number of pages to show and set current page to the first object
        [_pageControl setNumberOfPages:[_pages count]];
        [_pageControl setCurrentPage:0];
        //calculate the page control width considering that a dot is 20px, so we can multiply by the number of page to have the width of the page control
        int pWidth = kDotWidth * [_pages count];
        //calculate the scroll view center
        CGFloat scrollViewCenterPointX = self.frame.size.width / 2;
        //calculate the X and Y coordinates of the page control
        int pageControlX = scrollViewCenterPointX - (pWidth / 2);
        //int pageControlY = self.frame.origin.y + self.frame.size.height + 5;
        int pageControlY = self.frame.size.height / 2 + 70;
        
        //set the frame of the page control
        [_pageControl setFrame:CGRectMake(pageControlX, pageControlY, pWidth, 36)];
        //set target and selector for page control
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        //set colors for indicators
       // [_pageControl setPageIndicatorTintColor:[UIColor colorWithWhite:0.703 alpha:1.000]];
        
       // [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_pageControl setOnColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]] ;
        [_pageControl setOffColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]] ;
        [_pageControl setIndicatorDiameter: 8] ;
        [_pageControl setIndicatorSpace: 10] ;
        
        //add page control to superview
        //[[self superview] addSubview:_pageControl];
        if (!_lblCount) {
            _lblCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame), 15)];
            _lblCount.textAlignment = NSTextAlignmentCenter;
            _lblCount.textColor = BaseColor;
            _lblCount.font = [UIFont systemFontOfSize:14.0f];
            _lblCount.text = [NSString stringWithFormat:@"%d/%lu",_currentPage + 1,(unsigned long)_pages.count];
            [[self superview] addSubview:_lblCount];
        }else {
            _lblCount.text = [NSString stringWithFormat:@"%d/%lu",_currentPage + 1,(unsigned long)_pages.count];
        }
        
    } else {
        //remove the page control from superview
        for (UIPageControl *pControl in [[self superview] subviews]) {
            if ([pControl isEqual:_pageControl]) {
                [_pageControl removeFromSuperview];
            }
        }
    }
}

//set the color of the current page dot
- (void)setPageControlCurrentPageColor:(UIColor *)pageControlCurrentPageColor {
    _pageControlCurrentPageColor = pageControlCurrentPageColor;
    //_pageControl.currentPageIndicatorTintColor = pageControlCurrentPageColor;
}

//set the color of the others pages indicators
- (void)setPageControlOtherPagesColor:(UIColor *)pageControlOtherPagesColor {
    _pageControlOtherPagesColor = pageControlOtherPagesColor;
    //_pageControl.pageIndicatorTintColor = pageControlOtherPagesColor;
}

#pragma mark - Add pages

//add pages to the scrollview
- (void)addPages:(NSArray *)pages {
    _pages = pages;
    NSUInteger numberOfPages = [pages count];
    for (int i = 0; i < [pages count]; i++) {
        CGRect frame;
        frame.origin.x = self.frame.size.width * i;
        frame.origin.y = 20;
        frame.size = self.frame.size;
        UIView *view = [pages objectAtIndex:i];
        [view setFrame:frame];
        [self addSubview:view];
        
    }
    self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
}

#pragma mark - Change page through page control

//method for paging
- (void)changePage:(id)sender {
    //update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.frame.size.width * _pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.frame.size;
	[self scrollRectToVisible:frame animated:YES];
	pageControlBeingUsed = YES;
}

#pragma mark - ScrollView delegate
//methods for paging
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		//switch the page when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.frame.size.width;
		NSInteger page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.currentPage = page;
        _pageControl.currentPage = self.currentPage;
	}
    _lblCount.text= @"";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CurrentCardIdentify" object:self];
    NSLog(@"currentPAge = %d",_currentPage);
    _lblCount.text = [NSString stringWithFormat:@"%d/%lu",_currentPage+1,(unsigned long)_pages.count];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
	pageControlBeingUsed = NO;
}

@end
