//
//  NSMutableDictionary+KMKit.m
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 01/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import "NSMutableDictionary+KMKit.h"

@implementation NSMutableDictionary (KMKit)

- (void)setCanNilObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject == nil) {
        return;
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end
