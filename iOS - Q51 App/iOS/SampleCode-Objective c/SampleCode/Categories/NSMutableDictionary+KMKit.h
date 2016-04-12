//
//  NSMutableDictionary+KMKit.h
//  Template
//
//  Created by Wingstech Solutions Pvt. Ltd. on 01/07/14.
//  Copyright (c) 2014 Wingstech Solutions Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (KMKit)

- (void)setCanNilObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
