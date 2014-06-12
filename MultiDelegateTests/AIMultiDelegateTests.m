//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <XCTest/XCTest.h>

#import "AIMultiDelegate.h"
#import "AIScrollViewDelegate.h"


@interface AIMultiDelegateTests : XCTestCase
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
    XCTAssertEqual(multiDelegate.delegates.count, 1u);
    XCTAssertEqual((__bridge id)[multiDelegate.delegates pointerAtIndex:0], testDelegate);
    
    NSObject* testDelegate1 = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate1 beforeDelegate:testDelegate];
    XCTAssertEqual(multiDelegate.delegates.count, 2u);
    XCTAssertEqual((__bridge id)[multiDelegate.delegates pointerAtIndex:0], testDelegate1);
    
    NSObject* testDelegate2 = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate2 afterDelegate:testDelegate];
    XCTAssertEqual(multiDelegate.delegates.count, 3u);
    XCTAssertEqual((__bridge id)[multiDelegate.delegates pointerAtIndex:2], testDelegate2);
}

- (void)testAddBeforeAndAfterNil {
    NSObject* testDelegate = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate afterDelegate:nil];
    XCTAssertEqual(multiDelegate.delegates.count, 1u);
    XCTAssertEqual((__bridge id)[multiDelegate.delegates pointerAtIndex:0], testDelegate);
    
    [multiDelegate removeAllDelegates];
    [multiDelegate addDelegate:testDelegate beforeDelegate:nil];
    XCTAssertEqual(multiDelegate.delegates.count, 1u);
    XCTAssertEqual((__bridge id)[multiDelegate.delegates pointerAtIndex:0], testDelegate);
}

- (void)testRemoveDelegate {
    NSObject* testDelegate = [[NSObject alloc] init];
    [multiDelegate addDelegate:testDelegate];
    XCTAssertEqual(multiDelegate.delegates.count, 1u);
    
    [multiDelegate removeDelegate:testDelegate];
    XCTAssertEqual(multiDelegate.delegates.count, 0u);
}

- (void)testRespondsToSelector {
    XCTAssertFalse([multiDelegate respondsToSelector:@selector(scrollViewDidScroll:)]);
    
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate];
    
    XCTAssertTrue([multiDelegate respondsToSelector:@selector(scrollViewDidScroll:)]);
    XCTAssertFalse([multiDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]);
}

- (void)testForwardInvocation {
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate];
    
    XCTAssertEqual(0, testDelegate.scrollCount);
    [(id)multiDelegate scrollViewDidScroll:nil];
    XCTAssertEqual(1, testDelegate.scrollCount);
}

- (void)testReturnValue {
    AIScrollViewDelegate* testDelegate = [[AIScrollViewDelegate alloc] init];
    testDelegate.shouldScrollToTop = YES;
    [multiDelegate addDelegate:testDelegate];
    
    BOOL shouldScroll = [(id)multiDelegate scrollViewShouldScrollToTop:nil];
    XCTAssertTrue(shouldScroll);
}

- (void)testReturnValueOfMultipleDelegates {
    AIScrollViewDelegate* testDelegate1 = [[AIScrollViewDelegate alloc] init];
    testDelegate1.shouldScrollToTop = NO;
    [multiDelegate addDelegate:testDelegate1];
    
    AIScrollViewDelegate* testDelegate2 = [[AIScrollViewDelegate alloc] init];
    testDelegate2.shouldScrollToTop = YES;
    [multiDelegate addDelegate:testDelegate2];
    
    BOOL shouldScroll = [(id)multiDelegate scrollViewShouldScrollToTop:nil];
    XCTAssertTrue(shouldScroll);
}

- (void)testEmpty {
    multiDelegate.silentWhenEmpty = YES;
    XCTAssertNoThrow([(id)multiDelegate scrollViewDidScroll:nil], @"Should not throw an exception when empty");
}

- (void)testDeallocatedDelegate {
    AIScrollViewDelegate* testDelegate1 = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate1];

    AIScrollViewDelegate* testDelegate2 = [[AIScrollViewDelegate alloc] init];
    [multiDelegate addDelegate:testDelegate2];

    // Force deallocation of one delegate
    testDelegate1 = nil;

    XCTAssertNoThrow([(id)multiDelegate scrollViewDidScroll:nil], @"Should not thrown an exception if a delegate was deallocated");
}

@end
