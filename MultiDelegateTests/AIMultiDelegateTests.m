//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <SenTestingKit/SenTestingKit.h>

#import "AIMultiDelegate.h"
#import "AIScrollViewDelegate.h"


@interface AIMultiDelegateTests : SenTestCase
@end


@implementation AIMultiDelegateTests {
    AIMultiDelegate* multiDelegate;
}

- (void)setUp {
    [super setUp];
    multiDelegate = [[AIMultiDelegate alloc] init];
}

- (void)tearDown {
    multiDelegate = nil;
    [super tearDown];
}

- (void)testAddDelegate {
    NSObject* testDelegate = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate];
    STAssertEquals(multiDelegate.delegates.count, 1u, nil);
    STAssertEquals([multiDelegate.delegates objectAtIndex:0], testDelegate, nil);
    
    NSObject* testDelegate1 = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate1 beforeDelegate:testDelegate];
    STAssertEquals(multiDelegate.delegates.count, 2u, nil);
    STAssertEquals([multiDelegate.delegates objectAtIndex:0], testDelegate1, nil);
    
    NSObject* testDelegate2 = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate2 afterDelegate:testDelegate];
    STAssertEquals(multiDelegate.delegates.count, 3u, nil);
    STAssertEquals([multiDelegate.delegates objectAtIndex:2], testDelegate2, nil);
}

- (void)testAddBeforeAndAfterNil {
    NSObject* testDelegate = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate afterDelegate:nil];
    STAssertEquals(multiDelegate.delegates.count, 1u, nil);
    STAssertEquals([multiDelegate.delegates objectAtIndex:0], testDelegate, nil);
    
    [multiDelegate removeAllDelegates];
    [multiDelegate addDelegate:testDelegate beforeDelegate:nil];
    STAssertEquals(multiDelegate.delegates.count, 1u, nil);
    STAssertEquals([multiDelegate.delegates objectAtIndex:0], testDelegate, nil);
}

- (void)testRemoveDelegate {
    NSObject* testDelegate = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate];
    STAssertEquals(multiDelegate.delegates.count, 1u, nil);
    
    [multiDelegate removeDelegate:testDelegate];
    STAssertEquals(multiDelegate.delegates.count, 0u, nil);
}

- (void)testRespondsToSelector {
    STAssertFalse([multiDelegate respondsToSelector:@selector(scrollViewDidScroll:)], nil);
    
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate];
    
    STAssertTrue([multiDelegate respondsToSelector:@selector(scrollViewDidScroll:)], nil);
    STAssertFalse([multiDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)], nil);
}

- (void)testForwardInvocation {
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate];
    
    STAssertEquals(0, testDelegate.scrollCount, nil);
    [(id)multiDelegate scrollViewDidScroll:nil];
    STAssertEquals(1, testDelegate.scrollCount, nil);
}

- (void)testReturnValue {
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    testDelegate.shouldScrollToTop = YES;
    [multiDelegate addDelegate:testDelegate];
    
    BOOL shouldScroll = [(id)multiDelegate scrollViewShouldScrollToTop:nil];
    STAssertTrue(shouldScroll, nil);
}

- (void)testReturnValueOfMultipleDelegates {
    AIScrollViewDelegate* testDelegate1 = [[AIScrollViewDelegate alloc] init];
    testDelegate1.shouldScrollToTop = NO;
    [multiDelegate addDelegate:testDelegate1];
    
    AIScrollViewDelegate* testDelegate2 = [[AIScrollViewDelegate alloc] init];
    testDelegate2.shouldScrollToTop = YES;
    [multiDelegate addDelegate:testDelegate2];
    
    BOOL shouldScroll = [(id)multiDelegate scrollViewShouldScrollToTop:nil];
    STAssertTrue(shouldScroll, nil);
}

- (void)testEmpty {
    multiDelegate.silentWhenEmpty = YES;
    STAssertNoThrow([(id)multiDelegate scrollViewDidScroll:nil], @"Should not throw an exception when empty");
}

@end
