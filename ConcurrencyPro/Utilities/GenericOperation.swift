//
//  GenericOperation.swift
//  ConcurrencyPro
//
//  Created by Connor Przybyla on 5/2/22.
//

import Foundation

/// Remember, any subclass of Operation has four states: Ready, Executing, Finished, Canceled.
/// In addition to defining dependencies for operations, the ability to cancel a specific operation that has been queued is one of the biggest advantages to using NSOperation.

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

