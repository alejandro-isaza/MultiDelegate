//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <UIKit/UIKit.h>


@interface AIScrollViewDelegate : NSObject <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger scrollCount;
@property (assign, nonatomic) BOOL shouldScrollToTop;

@end
