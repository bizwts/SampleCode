//
//  UIButton+KMBlock.m
//  Populator
//
//  Created by Wingstech Solutions Pvt. Ltd. on 09/04/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "UIButton+KMBlock.h"
#import <objc/runtime.h>

@implementation UIButton (KMBlock)

static char overviewKey;

@dynamic actions;

- (void) setAction:(NSString*)action withBlock:(void(^)())block {
    
    if ([self actions] == nil) {
        [self setActions:[[NSMutableDictionary alloc] init]];
    }
    
    [[self actions] setObject:[block copy] forKey:action];
    
    if ([kUIButtonBlockTouchUpInside isEqualToString:action]) {
        [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([kUIButtonBlockTouchDown isEqualToString:action]) {
        [self addTarget:self action:@selector(doTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
}

- (void)setActions:(NSMutableDictionary*)actions {
    objc_setAssociatedObject (self, &overviewKey,actions,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)actions {
    return objc_getAssociatedObject(self, &overviewKey);
}

- (void)doTouchUpInside:(id)sender {
    void(^block)();
    block = [[self actions] objectForKey:kUIButtonBlockTouchUpInside];
    block();
}

- (void)doTouchDown:(id)sender {
    void(^block)();
    block = [[self actions] objectForKey:kUIButtonBlockTouchDown];
    block();
}

@end
