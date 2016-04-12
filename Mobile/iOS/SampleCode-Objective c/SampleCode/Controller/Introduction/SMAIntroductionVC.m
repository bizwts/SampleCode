//
//  SMAIntroductionVC.m
//  SignMe
//
//  Created by WTS on 04/03/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "SMAIntroductionVC.h"
#import "Macros.h"
#import "Themes.h"
#import "UIImage+KMKit.h"
#import "SMALoginViewController.h"

static NSString * const sampleDescription1 = @"Welcome to Sign Me, this is a new technique on finding talent. Like a dating app you, swipe left for NO and right for YES.";
static NSString * const sampleDescription2 = @"There are green buttons to indicate if the talent representative is looking for new talent. If there is a green dot next to their name you can submit your profile, if there is a red dot next to their name you cannot submit. Also you should always download your resume if you have one.  You also may not ask talent to work for free off this app. There are plenty of websites for that, so we will not follow suit of that.";
static NSString * const sampleDescription3 = @"Please only contact talent if you can put them in paid work. We are constantly doing updates to give all user the best advantage of finding the right person for your needs. Thank you.";

@interface SMAIntroductionVC()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageIndicator;
@property (nonatomic, strong) NSArray *aryData;
@property NSInteger pageNumber;
@property (nonatomic, strong) UIButton *btnSkip;

@end

@implementation SMAIntroductionVC

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = true;
    [self performSelector:@selector(addUIControl) withObject:nil afterDelay:0.0];
    _pageNumber = 3;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}

- (void)addUIControl {
    [self.view addSubview:[self scrollView]];
    _aryData = @[[UIColor grayColor],[UIColor lightGrayColor],[UIColor colorWithRed:0.750 green:0.500 blue:0.500 alpha:1.000]];
    _aryData = @[@{@"Color":[UIColor colorWithWhite:0.902 alpha:1.000],@"Data":sampleDescription1},@{@"Color":[UIColor colorWithWhite:0.795 alpha:1.000],@"Data":sampleDescription2},@{@"Color":[UIColor colorWithWhite:0.781 alpha:1.000],@"Data":sampleDescription3}];
    [self performSelector:@selector(addIntroductionView) withObject:nil afterDelay:0.0];
    [self.view addSubview:[self pageIndicator]];
    [self.view addSubview:[self btnSkip]];
    _scrollView.contentSize = CGSizeMake(WIDTH(self.view) * 3, HEIGHT(_scrollView));
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view) - 50)];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        [_scrollView setShowsHorizontalScrollIndicator:false];
        [_scrollView setShowsVerticalScrollIndicator:false];
        _scrollView.backgroundColor = TitleColor;
    }
    return _scrollView;
}

- (UIPageControl *)pageIndicator {
    if (!_pageIndicator) {
        _pageIndicator = [[UIPageControl alloc]initWithFrame:CGRectMake(0, HEIGHT(self.view) - 65, WIDTH(self.view), 15)];
        _pageIndicator.numberOfPages = 3;
        _pageIndicator.pageIndicatorTintColor = GrayColor;
        _pageIndicator.currentPageIndicatorTintColor = BaseColor;
    }
    return _pageIndicator;
}

#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView");
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageIndicator.currentPage = page;
}

- (void)addIntroductionView {
    int index = 0;
    for (NSDictionary *dic in _aryData) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH(_scrollView) * index, 0, WIDTH(_scrollView), HEIGHT(_scrollView))];
        view.backgroundColor = [dic valueForKey:@"Color"];
        [_scrollView addSubview:view];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH(_scrollView) * index), HEIGHT(_scrollView) / 3 * 2, WIDTH(_scrollView), HEIGHT(_scrollView) / 3)];
        contentView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:contentView];
        
        UILabel *lblData = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH(contentView) - 40, HEIGHT(contentView) - 20)];
        lblData.textColor = BaseColor;
        lblData.numberOfLines = 6;
        lblData.lineBreakMode = NSLineBreakByWordWrapping;
        lblData.font = [UIFont systemFontOfSize:14.0f];
        lblData.textAlignment = NSTextAlignmentCenter;
        lblData.backgroundColor = [UIColor clearColor];
        lblData.text = [dic valueForKey:@"Data"];
        [contentView addSubview:lblData];
        index++;
    }
}

- (UIButton *)btnSkip {
    if (!_btnSkip) {
        _btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSkip.frame = CGRectMake(0, HEIGHT(self.view) - 50, WIDTH(self.view), 50);
        _btnSkip.tag = 1;
        [_btnSkip setTitle:@"SKIP" forState:UIControlStateNormal];
        [_btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSkip.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnSkip addTarget:self action:@selector(didTappedSkipButton) forControlEvents:UIControlEventTouchUpInside];
        [_btnSkip setBackgroundImage:[UIImage imageWithColor:BaseColor cornerRadius:0] forState:UIControlStateNormal];
        [_btnSkip setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0] forState:UIControlStateHighlighted];
        [_btnSkip setTitleColor:BaseColor forState:UIControlStateHighlighted];
        _btnSkip.layer.borderColor = BaseColor.CGColor;
        _btnSkip.layer.borderWidth = 1.0f;
    }
    return _btnSkip;
}

- (void)didTappedSkipButton {
    SMALoginViewController *login = [[SMALoginViewController alloc]init];
    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController pushViewController:login animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];

}

@end
