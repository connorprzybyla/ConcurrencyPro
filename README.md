In this project, you'll find `ImageProcessor` defined as a final class. The `final` keyword is used here in order to improve runtime performance since more optimizations can be made due to the compiler being able to make a direct function call.

In order to make this implementation testable, a protocol, `URLSessionable` is defined in `URLSession+Extensions.swift` with a few others such as `URLSessionDataTaskable`. Mocking URLSession is now easier than ever before. 

DispatchGroups are a fundamental to Grand Central Dispatch and allow developers to block threads in just a few lines of code. The pattern is pretty straightforward for simple user cases. Make sure to call `enter()` before executing an individual task or work item, remember to always call `leave()` when finished or in a defer block of a closure (forget this, and you may deadlock your iOS application!). Lastly, `notify()` is used to setup a block to execute upon completion of all tasks.

NSCache is used to save any UIImage we may have already downloaded. NSCache is thread-safe and provides O(1) lookup in most cases. 
