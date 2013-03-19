//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import <Foundation/Foundation.h>


@interface AIArrayTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray* array;

+ (instancetype)arrayDataSourceWithArray:(NSArray*)array;
- (id)initWithArray:(NSArray*)array;

- (id)itemAtIndex:(NSUInteger)index;

@end
