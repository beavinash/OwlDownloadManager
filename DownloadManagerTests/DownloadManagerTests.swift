//
//  DownloadManagerTests.swift
//  DownloadManagerTests
//
//  Created by Avinash Reddy on 3/3/19.
//  Copyright © 2019 725-1 Corporation. All rights reserved.
//

import XCTest
import MockService

class DownloadManagerTests: XCTestCase {
    
    // Properties for storing metadata and result data
    var dataMetaArray = [String]()
    var resultFetchArrayData = [String]()

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // This is a performance test case.
    func testPerformanceOfService() {
        self.measure {
            // Put the code you want to measure the time of here.
            serviceForUnpredictableSlowService()
        }
    }
    
    // Confirm that the UnpredictableSlowService initalizes a shared object
    func testUnpredictableSlowServiceSucceeds() {
        let sharedSingletonService: UnpredictableSlowService = UnpredictableSlowService.shared
        XCTAssertNotNil(sharedSingletonService)
    }
    
    // Confirm that the UnpredictableSlowService initalizes with nil value
    func testUnpredictableSlowServiceFails() {
        let sharedSingletonServiceNil: UnpredictableSlowService? = nil
        XCTAssertNil(sharedSingletonServiceNil)
    }
    
    // Confirm that the dataMetaArray has initialized
    func testDataMetaArraySucceeds() {
        XCTAssertNotNil(dataMetaArray)
    }
    
    // Confirm that the dataMetaArray is empty
    func testDataMetaArrayEmpty() {
        XCTAssertTrue(dataMetaArray == [])
    }
    
    // Confirm that the resultFetchArrayData has initialized
    func testresultFetchArrayDataSucceeds() {
        XCTAssertNotNil(resultFetchArrayData)
    }
    
    // Confirm that the resultFetchArrayData is empty
    func testresultFetchArrayDataEmpty() {
        XCTAssertTrue(resultFetchArrayData == [])
    }
    
    // Confirm that the resultFetchArrayData succeeds
    func testResultFetchArrayDataSucceeds() {
        serviceForUnpredictableSlowService()
        XCTAssertNotNil(resultFetchArrayData)
    }
    
    // Confirm that the resultFetchArrayData is 0
    func testResultFetchArrayDataCount() {
        serviceForUnpredictableSlowService()
        XCTAssertTrue(resultFetchArrayData.count == 0)
    }
    
    // Service initalization for UnpredictableSlowService
    func serviceForUnpredictableSlowService() {
        
        // service object initalization for Singleton access.
        let service: UnpredictableSlowService = UnpredictableSlowService.shared
        // Background process in a pool of threads i.e. managed by Grand Central Dispatch.
        DispatchQueue.global(qos: .background).async {
            // Function call for fetching meta data with a response data from a Singleton class.
            service.fetchMetaData { (data) in
                // Add data to a local variable.
                if let data = data {
                    self.dataMetaArray = data
                }
            }
            
            // Update of UI starts here on a main thread.
            for key in self.dataMetaArray {
                // Function call for fetching data based on the give key with a response data from a Singleton class.
                service.fetch(key: key, completion: { (data) in
                    // Main Thread execution for display of data in a TableView.
                    DispatchQueue.main.async {
                        // Add data to a local variable.
                        self.resultFetchArrayData.append(data)
                    }
                })
                // Confirm of resultFetchArrayData contains a value
                XCTAssertTrue(self.resultFetchArrayData.count == 1)
            }
        }
    }
    

}
