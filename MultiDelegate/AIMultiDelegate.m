//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import "AIMultiDelegate.h"


@implementation AIMultiDelegate {
    NSMutableArray* _delegates;
}

- (id)init {
    return [self initWithDelegates:nil];
}

- (id)initWithDelegates:(NSArray*)delegates {
    self = [super init];
    if (!self)
        return nil;
    
    _delegates = CFBridgingRelease(CFArrayCreateMutable(NULL, 0, NULL));
    for (id delegate in delegates)
        [_delegates addObject:delegate];
    
    return self;
}

- (void)addDelegate:(id)delegate {
    [_delegates addObject:delegate];
}

- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate {
    NSUInteger index = [_delegates indexOfObjectIdenticalTo:otherDelegate];
    if (index == NSNotFound)
        index = _delegates.count;
    [_delegates insertObject:delegate atIndex:index];
}

- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate {
    NSUInteger index = [_delegates indexOfObjectIdenticalTo:otherDelegate];
    if (index == NSNotFound)
        index = 0;
    else
        index += 1;
    [_delegates insertObject:delegate atIndex:index];
}

- (void)removeDelegate:(id)delegate {
    [_delegates removeObject:delegate];
}

- (void)removeAllDelegates {
    [_delegates removeAllObjects];
}

- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector])
        return YES;
    
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector])
            return YES;
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (signature)
        return  signature;
    
    for (id delegate in _delegates) {
        signature = [delegate methodSignatureForSelector:selector];
        if (signature)
            break;
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL selector = [invocation selector];
    BOOL responded = NO;
    
    for (id delegate in _delegates) {
        if ([delegate respondsToSelector:selector]) {
            [invocation invokeWithTarget:delegate];
            responded = YES;
        }
    }
    
    if (!responded)
        [self doesNotRecognizeSelector:selector];
}

@end
