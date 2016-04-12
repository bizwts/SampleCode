//
//  UpdateActorHeadShotView.m
//  SignMe
//
//  Created by WTS on 12/02/16.
//  Copyright © 2016 wings. All rights reserved.
//

#import "UpdateActorHeadShotView.h"
#import "UIImageView+WebCache.h"

@implementation UpdateActorHeadShotView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
        [self addUIControl];
    }
    return self;
}

- (void)addUIControl {
    [self addSubview:[self scrollView]];
    [[self scrollView] addSubview:[self btnFirstHeadShot]];
    [[self scrollView] addSubview:[self btnAddHeadShot]];
    [[self scrollView] addSubview:[self btnViewAll]];
    //[[self scrollView] addSubview:[self btnSave]];
    //_scrollView.contentSize = CGSizeMake(WIDTH(self), MaxY(_btnSave) + 20);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeadShotData) name:notiUpdateActorHeadShot object:nil];
}

- (UIButton *)btnViewAll {
    if (!_btnViewAll) {
        _btnViewAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnViewAll.frame = CGRectMake(0, HEIGHT(self) - 50, WIDTH(self) / 2 - 2, 50);
        _btnViewAll.tag = 1;
        [_btnViewAll setTitle:@"View All" forState:UIControlStateNormal];
        [_btnViewAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnViewAll.titleLabel.font = [UIFont systemFontOfSize:16.0];
        // [_btnAddHeadShot addTarget:self action:@selector(didTappedAddHeadShot:) forControlEvents:UIControlEventTouchUpInside];
        _btnViewAll.layer.masksToBounds = YES;
        _btnViewAll.tag = 1;
        [_btnViewAll setBackgroundImage:[UIImage imageWithColor:BaseColor cornerRadius:0] forState:UIControlStateNormal];
        [_btnViewAll setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0] forState:UIControlStateHighlighted];
        [_btnViewAll setTitleColor:BaseColor forState:UIControlStateHighlighted];
        _btnViewAll.layer.borderColor = BaseColor.CGColor;
        _btnViewAll.layer.borderWidth = 1.0f;
        [_btnViewAll addTarget:self action:@selector(didTappedPlusButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnViewAll;
}

- (UIButton *)btnAddHeadShot {
    if (!_btnAddHeadShot) {
        _btnAddHeadShot = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAddHeadShot.frame = CGRectMake(WIDTH(self) / 2 + 2, HEIGHT(self) - 50, WIDTH(self) / 2 - 2, 50);
        _btnAddHeadShot.tag = 6;
        [_btnAddHeadShot setTitle:@"Add" forState:UIControlStateNormal];
        [_btnAddHeadShot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAddHeadShot.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_btnAddHeadShot addTarget:self action:@selector(didTappedPlusButton:) forControlEvents:UIControlEventTouchUpInside];
        _btnAddHeadShot.layer.masksToBounds = YES;
        [_btnAddHeadShot setBackgroundImage:[UIImage imageWithColor:BaseColor cornerRadius:0] forState:UIControlStateNormal];
        [_btnAddHeadShot setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRadius:0] forState:UIControlStateHighlighted];
        [_btnAddHeadShot setTitleColor:BaseColor forState:UIControlStateHighlighted];
        _btnAddHeadShot.layer.borderColor = BaseColor.CGColor;
        _btnAddHeadShot.layer.borderWidth = 1.0f;
    }
    return _btnAddHeadShot;
}

- (UIButton *)btnFirstHeadShot {
    if (!_btnFirstHeadShot) {
        _btnFirstHeadShot = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFirstHeadShot.frame = CGRectMake(5, 5, WIDTH(self) - 10, HEIGHT(self) - 60);
        _btnFirstHeadShot.layer.cornerRadius = 6;
        _btnFirstHeadShot.tag = 1;
        _btnFirstHeadShot.backgroundColor = [UIColor whiteColor];
        _btnFirstHeadShot.layer.masksToBounds = true;
        _btnFirstHeadShot.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_btnFirstHeadShot setImage:[UIImage imageNamed:@"ImagePlaceHolder"] forState:UIControlStateNormal];
        [_btnFirstHeadShot addTarget:self action:@selector(didTappedPlusButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFirstHeadShot;
}

#pragma mark Plus Button Event
- (void)didTappedPlusButton:(UIButton *)sender {
    NSLog(@"didTappedPlusButton = %ld",(long)sender.tag);
    //_maskView.hidden = false;
    //_maskView.frame = CGRectMake(X(sender), Y(sender), 30, 30);
    //_btnContinue.hidden = true;
    
    switch (sender.tag) {
        case 1:{
            //_OperationView.hidden = false;
        }
            break;
        case 2:{
            //_OperationView.hidden = false;
        }
            break;
        case 3:{
            //_OperationView.hidden = false;
        }
            break;
        case 4:{
            //_OperationView.hidden = false;
        }
            break;
        case 5:{
            //_OperationView.hidden = false;
        }
            break;
        case 6:{
            //_OperationView.hidden = true;
        }
            break;
            
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(didTappedClickPlusButton:)]) {
        [self.delegate didTappedClickPlusButton:sender];
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), HEIGHT(self))];
    }
    return _scrollView;
}

- (void)updateHeadShotData{
    NSLog(@"countinggg = %lu",(unsigned long)[AppDelegate sharedDelegate].arrImages.count);
    if ([AppDelegate sharedDelegate].arrImages.count>0) {
        [_btnFirstHeadShot.imageView setShowActivityIndicatorView:YES];
        [_btnFirstHeadShot.imageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [_btnFirstHeadShot.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppDelegate sharedDelegate].strBaseServerPath,[[AppDelegate sharedDelegate].arrImages[0] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"ProfilePlaceHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imgURL) {
//            //[_btnFirstHeadShot setImage:image forState:UIControlStateNormal];
//            [_btnFirstHeadShot setImage:[[AppDelegate sharedDelegate] resizeImage:image scaledToSize:CGSizeMake(WIDTH(_btnFirstHeadShot), HEIGHT(_btnFirstHeadShot))] forState:UIControlStateNormal];
//        }];
        [_btnFirstHeadShot.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[AppDelegate sharedDelegate].strBaseServerPath,[[[AppDelegate sharedDelegate].arrImages lastObject] valueForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"ProfilePlaceHolder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imgURL) {
            //[_btnFirstHeadShot setImage:image forState:UIControlStateNormal];
            [_btnFirstHeadShot setImage:[[AppDelegate sharedDelegate] resizeImage:image scaledToSize:CGSizeMake(WIDTH(_btnFirstHeadShot), HEIGHT(_btnFirstHeadShot))] forState:UIControlStateNormal];
        }];
    }
    if ([AppDelegate sharedDelegate].arrImages.count>0) {
        [_btnViewAll setTitle:[NSString stringWithFormat:@"View All [%lu]",(unsigned long)[AppDelegate sharedDelegate].arrImages.count] forState:UIControlStateNormal];
    }
    if ([AppDelegate sharedDelegate].arrImages.count == 10) {
        _btnAddHeadShot.enabled = false;
    }else
        _btnAddHeadShot.enabled = true;
}

-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a bitmap context.
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
