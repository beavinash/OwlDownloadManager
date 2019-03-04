//
//  UnpredictableSlowService.swift
//  MockService
//
//  Created by Mei Yu on 11/12/18.
//  Copyright © 2018 725-1 Corporation. All rights reserved.
//

import Foundation

public class UnpredictableSlowService {
    
    public static let shared: UnpredictableSlowService = UnpredictableSlowService()
    
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
        let value = "Result for \(key)"
        
        completion(value)
    }
    
}
