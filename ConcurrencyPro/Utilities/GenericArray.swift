//
//  GenericArray.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 4/29/22.
//

import Foundation

/// Concurrency is a fundamental to computer science and a key aspect to performant iOS applications. Although Apple has done some excellent work to assist developers with issues relating
/// to concurrency and multithreading, it is up to us developers to follow best practices and ensure our code is guarenteed to execute as expected even in unknown circumstances.

// MARK: - Solution #1 - DispatchQueue sync - (Accepted)

/// Although the example below enforces mutual execlusion. there are some very notable drawbacks. When we use sync, we are effectively blocking the current thread
/// execution.
/// With a serial queue, we cannot use concurrency to improve performance. This is a huge drawback to this implementation approach.

final class GenericArrayNaive<T> {
    private var array: [T]?
    private let dispatchQueue = DispatchQueue(label: "generic-array-naive-example")
    
    init(array: [T]?) {
        self.array = array
    }
    
    func append(_ element: T) {
        dispatchQueue.sync {
            // Critical section
            self.array?.append(element)
        }
    }
    
    func getValue(at index: Int) -> T? {
        var value: T?
        dispatchQueue.sync {
            // Critical section
            value = array?[index]
        }
        return value
    }
}

// MARK: - Solution #2 - DispatchQueue async - (Accepted)

/// Here we have a concurrent dispatch queue that we use to keep our critical sections protected. In the case of appending to the array, we simply wrap the append in a block that will
/// ensure that the item will asyncronously execute at some point in time with a specific flag type `barrier`. This flag will block any thread attempting to read/write to the resources in this block.

final class GenericArray<T> {
    private var array: [T]?
    private let dispatchQueue = DispatchQueue(label: "generic-array-example", attributes: .concurrent)
    
    init(array: [T]?) {
        self.array = array
    }
    
    func append(_ element: T) {
        dispatchQueue.async(flags: .barrier) {
            // Critical section
            self.array?.append(element)
        }
    }
    
    func getValue(at index: Int) -> T? {
        var value: T?
        dispatchQueue.sync {
            // Critical section
            value = array?[index]
        }
        return value
    }
}

// MARK: - Solution #3 - NSLock - (Accepted)

/// Prior to Actors, NSLock was perhaps the easiest and most lightweight way to protect critical sections and enforce mutual exclusion in an iOS application.
/// We can avoid the overhead that DispatchQueue's introduce and just rely of NSLock instead for mutual exclusion since at its core its really just a mutex. Also understand NSRecusiveLock() and why it was introduced as a way to prevent
/// deadlocking your application when attempting to acquire a lock multiple times by the same thread. In the example below, NSLock() is all we need since the critical sections never attempt to acquire locks. It's also faster than NSRecusiveLock()
/// so be sure to only use NSRecusiveLock() when you really need to.

final class GenericArrayWithNSLock<T> {
    private var array: [T]?
    private var lock = NSLock()
    
    init(array: [T]?) {
        self.array = array
    }
    
    func append(_ element: T) {
        lock.lock()
        // Critical section
        array?.append(element)
        lock.unlock()
    }
    
    func getValue(at index: Int) -> T? {
        var value: T?
        
        lock.lock()
        // Critical section
        value = array?[index]
        lock.unlock()
        
        return value
    }
}

// MARK: - Solution #4 - Swift Actors - (Accepted)

/// The latest and greatest from Swift 5.5. Use the keyword `actor` to enforce thread-safety. Threads are unable to access the resources in parallel.
/// Swift 5.7 has introduced the concept of distributed actors, which allows them to work over RPC! Simply use `distributed actor` and `distributed func`
/// if you want to experiment with this distributed form.

final actor GenericArrayActor<T> {
    private var array: [T]?
    
    init(array: [T]?) {
        self.array = array
    }
    
    func append(_ element: T) {
        // Critical section
        array?.append(element)
    }
    
    func getValue(at index: Int) -> T? {
        // Critical section
        array?[index]
    }
}
