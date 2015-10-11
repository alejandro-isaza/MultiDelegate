MultiDelegate
=============

MultiDelegate is a delegate multiplexing class for Objective-C. In other words, it will dispatch delegate methods to multiple objects, instead of being restricted to a single delegate object. You can also use it as a generic method dispatch mechanism. For more information see the [blog post](http://a-coding.com/delegate-multiplexing/).

[![Build Status](https://travis-ci.org/aleph7/MultiDelegate.svg?branch=master)](https://travis-ci.org/aleph7/MultiDelegate)

## Example

Suppose you have a `UITableView` and you want to implement the data source using two separate classes: one is the actual data source implementing the `tableView:numberOfRowsInSection:` method and the other one is the cell factory implementing the `tableView:cellForRowAtIndexPath:` method to construct the cells. 

First create an `AIMultiDelegate` instance. You need to keep a strong reference to this instance because most objects don't retain their delegates:
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


## Remarks

Keep this in mind
* Every method invocation will be forwarded to each object in the list in the order they were added.
* If a method returns a value the return value will be from the last object that responded to the method. For example if object `A` implements method `getInt` by returning `1`, object `B` implements `getInt` by returning `2` and object `C` doesn't implement `getInt`, calling `getInt` on an `AIMultiDelegate` containing `A`, `B` and `C` (in that order) will return `2`.
* `AIMultiDelegate` doesn't keep strong references to the objects added to it.
* Some objects only call `respondsToSelector:` when you first set the delegate to improve performance, so make sure you add all your delegates to the `AIMultiDelegate` before you set it as the delegate.


## Installation

If you are using [CocoaPods](https://github.com/cocoapods/cocoapods), add this to your `Podfile`:
```ruby
pod 'MultiDelegate'
```
Otherwise add `AIMultiDelegate.h/.m` to your project.
