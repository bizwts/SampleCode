//
//  KMFloatingTextField.m
//  Templates
//
//  Created by KETAN MODHA on 10/02/14.
//  Copyright (c) 2014 KETAN MODHA. All rights reserved.
//

#import "KMFloatingTextField.h"

@interface KMFloatingTextField ()

@property (nonatomic, strong, readonly) UIImageView * borderLabel;

@property (nonatomic, strong) UIView *border;
@property (nonatomic, strong) UIView *borderMask;

@end

@implementation KMFloatingTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
	    [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        
        // force setter to be called on a placeholder defined in a NIB/Storyboard
    	if (self.placeholder) {
        	self.placeholder = self.placeholder;
    	}
    }
    return self;
}

- (void)commonInit
{
    _floatingLabel = [UILabel new];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
	
    // some basic default fonts/colors
    _floatingLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _floatingLabelTextColor = [UIColor grayColor];
    _animateEvenIfNotFirstResponder = NO;
    
    self.clipsToBounds = NO;
    
//    [self addBorders];
}

- (void)addBorders {
    if (!_border) {
        _border = [UIView new];
        [self addSubview:_border];
    }
    [_border setBackgroundColor:_placeholderTextColor];
    [_border setFrame:CGRectMake(-4, self.bounds.size.height - 2, self.bounds.size.width + 10, 6)];

    if (!_borderMask) {
        _borderMask = [UIView new];
        [self addSubview:_borderMask];
    }
    [_borderMask setBackgroundColor:[UIColor whiteColor]];
    [_borderMask setFrame:CGRectMake(-2, self.bounds.size.height - 2, self.bounds.size.width + 6, 4)];
}

- (void)hideBorders {
    _border.alpha = 0.0;
    _borderMask.alpha = 0.0;
}

#pragma mark -

- (UIColor *)getLabelActiveColor
{
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    
    return [UIColor blueColor];
}

- (void) setFloatingLabelFont:(UIFont *)floatingLabelFont {
    _floatingLabelFont = floatingLabelFont;
    _floatingLabel.font = (_floatingLabelFont ? _floatingLabelFont : [UIFont boldSystemFontOfSize:12.0f]);
    self.placeholder = self.placeholder; // Force the label to lay itself out with the new font.
}

- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          -4.0f,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.font.lineHeight + _floatingLabelYPadding.floatValue,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        
    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)setLabelOriginForTextAlignment
{
    CGFloat originX = _floatingLabel.frame.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = (self.frame.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = self.frame.size.width - _floatingLabel.frame.size.width;
    }
    
    _floatingLabel.frame = CGRectMake(originX, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

#pragma mark - UITextField

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    
    _floatingLabel.text = placeholder;
    [_floatingLabel sizeToFit];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight+_floatingLabelYPadding.floatValue), 0.0f, 0.0f, 0.0f));
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], UIEdgeInsetsMake(ceilf(_floatingLabel.font.lineHeight+_floatingLabelYPadding.floatValue), 0.0f, 0.0f, 0.0f));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect = CGRectMake(rect.origin.x, rect.origin.y + (_floatingLabel.font.lineHeight / 2.0) + (_floatingLabelYPadding.floatValue / 2.0f), rect.size.width, rect.size.height);
    return rect;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setLabelOriginForTextAlignment];
    
    if (self.floatingLabelFont) {
        _floatingLabel.font = self.floatingLabelFont;
    }
    
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ? self.getLabelActiveColor : self.floatingLabelTextColor);
    if (!self.text || 0 == [self.text length]) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
    
//    [self addBorders];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    if (!_placeholderTextColor)
        _placeholderTextColor = [UIColor blackColor];

    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)])
    { // iOS7 and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: _placeholderTextColor, NSFontAttributeName: self.font};
        CGRect boundingRect;
        if ([self.placeholder respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        } else {
            CGSize rectSize = [self.placeholder sizeWithFont:self.font constrainedToSize:rect.size lineBreakMode:NSLineBreakByWordWrapping];
            boundingRect = CGRectMake(0, 0, rectSize.width, rectSize.height);
        }
        
        if (self.textAlignment == NSTextAlignmentLeft) {
            
            if ([self.placeholder respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
                [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
            }
            else {
                [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withFont:self.font];
            }
        }
        else if (self.textAlignment == NSTextAlignmentCenter) {
            if ([self.placeholder respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
                [self.placeholder drawAtPoint:CGPointMake((rect.size.width - boundingRect.size.width)/2, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
            }
            else {
                [self.placeholder drawAtPoint:CGPointMake((rect.size.width - boundingRect.size.width)/2, (rect.size.height/2)-boundingRect.size.height/2) withFont:self.font];
            }
        }
    }
    else { // iOS 6
//        [_placeholderTextColor setFill];
//        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
    }
}

#pragma mark - Accessibility

- (NSString *)accessibilityLabel
{
    NSString *accessibilityLabel;
    if ([self.text isEqualToString:@""] == NO) {
        accessibilityLabel = [self.floatingLabel accessibilityLabel];
    } else {
        accessibilityLabel = self.text;
    }
    return accessibilityLabel;
}

@end
