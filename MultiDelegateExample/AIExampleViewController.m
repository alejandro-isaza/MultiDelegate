//  Created by Alejandro Isaza on 13-03-18.
//  Copyright (c) 2013 Alejandro Isaza. All rights reserved.

#import "AIExampleViewController.h"

#import "AIArrayTableViewDataSource.h"
#import "AIMultiDelegate.h"

#define REUSE_IDENTIFIER @"Cell"


@implementation AIExampleViewController {
    AIMultiDelegate* _multiDelegate;
    AIArrayTableViewDataSource* _dataSource;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self)
        return nil;
    
    _multiDelegate = [[AIMultiDelegate alloc] init];
    [_multiDelegate addDelegate:self];
    
    _dataSource = [[AIArrayTableViewDataSource alloc] init];
    _dataSource.array = @[ @"Object 1", @"Object 2", @"Object 3" ];
    [_multiDelegate addDelegate:_dataSource];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSE_IDENTIFIER];
    
    // Multiplex the data source to split the implementation between
    // the data source and and the view controller
    self.tableView.dataSource = (id)_multiDelegate;
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    cell.textLabel.text = [_dataSource itemAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

@end
