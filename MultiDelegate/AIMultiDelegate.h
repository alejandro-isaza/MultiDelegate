//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <Foundation/Foundation.h>

/**
 AIMultiDelegate does delegate multiplexing; it will dispatch delegate methods to multiple objects.
 */
@interface AIMultiDelegate : NSObject

/**
 The array of registered delegates.
 */
@property (readonly, nonatomic) NSPointerArray* delegates;

/**
 Set whether to throw unrecognized selector exceptions when calling delegate methods on an empty AIMultiDelegate.
 
 When `slientWhenEmpty` is NO, the default, if a delegate selector is called and there are no registered delegates an
 unregonized selector execption will be thrown. Which, unless you have a try/catch block, will crash the app. Setting
 `silentWhenEmpt` to YES will silence the execptions by ignoring selector invocations when there are no registered
 delegates.
 */
@property (nonatomic, assign) BOOL silentWhenEmpty;

- (id)initWithDelegates:(NSArray*)delegates;

- (void)addDelegate:(id)delegate;
- (void)addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)addDelegate:(id)delegate afterDelegate:(id)otherDelegate;

- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
