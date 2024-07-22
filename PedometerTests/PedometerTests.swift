//
//  PedometerTests.swift
//  PedometerTests
//
//  Created by Gaurav Bhambhani on 7/22/24.
//

import CoreMotion
import XCTest

@testable import Pedometer

//final class PedometerTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

class PedometerTests: XCTestCase {
    
    func testPedometerSuccess() {
        // create mock pedometer and setup mock data
        let mockPedometer = MockPedometer()
        let mockData = CMPedometerData()
        mockData.setValue(1000, forKey: "numberOfSteps")
        mockData.setValue(500.0, forKey: "distance")
        mockPedometer.mockData = mockData
        
        let model = PedometerModel(pedometer: mockPedometer)
        
        let expectation = self.expectation(description: "pedometer updates")
        
        model.startPedometerUpdates { result in
            
            switch result {
            case .success(let data):
                XCTAssertEqual(data.steps, 1000)
                XCTAssertEqual(data.distance, 500.0)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func testPedometerFailure() {
        let mockPedometer = MockPedometer()
        let mockError = NSError(domain: "Pedometer", code: 1, userInfo: nil)
        mockPedometer.mockError = mockError
        
        let model = PedometerModel(pedometer: mockPedometer)
        
        let expectation = self.expectation(description: "Pedometer updates")
        
        model.startPedometerUpdates { result in
        
            switch result{
            case .success:
                XCTFail("Expected Failure, got Success")
            
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, mockError.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
