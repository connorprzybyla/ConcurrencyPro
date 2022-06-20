//
//  GenericOperationManager.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 6/20/22.
//

import Foundation

// MARK: - OperationQueueManageable

protocol OperationQueueManageable {
    func executeChain()
}

// MARK: - GenericOperationManager

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
