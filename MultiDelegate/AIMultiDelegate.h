//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <Foundation/Foundation.h>

@interface AIMultiDelegate : NSObject

@property (readonly, nonatomic) NSArray* delegates;

/**
 @discussion if set to YES, AIMultiDelegate will do nothing when a method is called on it but it has no delegates
 */
@property (nonatomic, assign) BOOL bailoutWhenEmpty;

- (id)initWithDelegates:(NSArray*)delegates;

- (void)addDelegate:(id)delegate;
- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate;

- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
