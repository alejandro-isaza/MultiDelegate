MultiDelegate
=============

MultiDelegate is a delegate multiplexing class for Objective-C. In other words, it will dispatch delegate methods to multiple objects, instead of being restricted to a single delegate object. You can also use it a generic method dispatch mechanism.


## Example

Suppose you have a `UITableView` and you want to implement the data source using two separate classes: one is the actual data source implementing the `tableView:numberOfRowsInSection:` method and the other one is the cell factory implementing the `tableView:cellForRowAtIndexPath:` method to construct the cells. 

First create an AIMultiDelegate instance. You need to keep a strong reference to this instance because most objects don't retain their delegates:
```objc
_multiDelegate = [[AIMultiDelegate alloc] init];
```

Then add all the actual delegates to the `_multiDelegate` object:
```
[_multiDelegate addDelegate:self];
[_multiDelegate addDelegate:_dataSource];
```

Finally set the table's data source as the delegate multiplexer:
```
self.tableView.dataSource = (id)_multiDelegate;
```

See the example project for the full source.


## Installation

Please use [CocoaPods](https://github.com/cocoapods/cocoapods) to add MultiDelegate to your project. Add this to your `Podfile`:
```ruby
pod 'MultiDelegate'
```
