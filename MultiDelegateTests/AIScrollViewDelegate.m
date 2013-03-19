//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import "AIScrollViewDelegate.h"


@implementation AIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    _scrollCount += 1;
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView*)scrollView {
    return _shouldScrollToTop;
}

@end
