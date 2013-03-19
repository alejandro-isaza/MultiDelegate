//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import "AIArrayTableViewDataSource.h"

@implementation AIArrayTableViewDataSource

+ (instancetype)arrayDataSourceWithArray:(NSArray*)array {
    return [[AIArrayTableViewDataSource alloc] initWithArray:array];
}

- (id)initWithArray:(NSArray*)array {
    self = [super init];
    self.array = array;
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [_array count];
}

- (id)itemAtIndex:(NSUInteger)index {
    return [_array objectAtIndex:index];
}

@end
