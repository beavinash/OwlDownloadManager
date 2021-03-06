//
//  UnpredictableSlowService.swift
//  MockService
//
//  Created by Mei Yu on 11/12/18.
//  Copyright © 2018 725-1 Corporation. All rights reserved.
//

import Foundation

public class UnpredictableSlowService {
    
    //MARK: - Properties
    
    // Singleton shared object initialization.
    public static let shared: UnpredictableSlowService = UnpredictableSlowService()
    
    // Lock object initalization support for executing 1 request at a time.
    private let lock = NSLock()
    
    //MARK: - Accessible Singleton functions for fetch data
    
    /**
     * Return a list of meta data
     */
    public func fetchMetaData(completion:@escaping([String]?) -> Void) {
        var keys: [String] = []
        for i in 0...300 {
            keys.append("\(i)")
        }
        completion(keys)
    }
    
    /**
     * Return the value for the given key.  Please implement it such this method only
     * support 1 request a time and response to a request 0.5 to 1 second each.
     */
    public func fetch(key: String,
                      completion:@escaping(String) -> Void) {
        
        // Lock function call to block a thread's ececution and relinquish of a previously acquired lock.
        lock.lock()
        defer {
            lock.unlock()
        }
        
        // Sleep function call for the response to a request from 0.5 to 1 second.
        usleep(useconds_t.random(in: 500000...1000000))
        
        // return result value for the given key.
        let value = "Result for \(key)"
        completion(value)
    }
    
}
