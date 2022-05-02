//
//  GenericOperation.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 5/2/22.
//

import Foundation

/// Remember, any subclass of Operation has four states: Ready, Executing, Finished, Canceled.
/// In addition to defining dependencies for operations, the ability to cancel a specific operation that has been queued is one of the biggest advantages to using Operation's.

final class GenericOperation: Operation {
    
    private let string: String
    
    init(string: String) {
        self.string = string
        super.init()
    }
    
    override func main() {
        // Remember to check is operation has been canceled prior to executing any heavyweight tasks
        guard !isCancelled else { return }
        print("GenericOperation is \(string)...")
    }
}


protocol OperationQueueManageable {
    func executeChain()
}

final class GenericOperationManager: OperationQueueManageable {
    
    private let operationQueue: OperationQueue
    
    init(operationQueue: OperationQueue) {
        self.operationQueue = operationQueue
    }
    
    func executeChain() {
        let profileOperation = GenericOperation(string: "fetching profile details.")
        let newsFeedOperation = GenericOperation(string: "fetching news feed details.")
        let marketPlaceOperation = GenericOperation(string: "fetching marketplace details.")
        
        // Create chain
        
        newsFeedOperation.addDependency(profileOperation)
        marketPlaceOperation.addDependency(newsFeedOperation)
        
        operationQueue.addOperation(profileOperation)
        operationQueue.addOperation(newsFeedOperation)
        operationQueue.addOperation(marketPlaceOperation)
        
        // Remember, completion blocks for operations are escaping and therefore,
        // the order of execution of these blocks is not guarenteed.
        
        profileOperation.completionBlock = {
            print("profileOperation completed.")
        }
        
        newsFeedOperation.completionBlock = {
            print("newsFeedOperation completed.")
        }
        
        marketPlaceOperation.completionBlock = {
            print("marketPlaceOperation completed.")
        }
    }
}
