//
//  MockPedometer.swift
//  PedometerTests
//
//  Created by Gaurav Bhambhani on 7/22/24.
//

import CoreMotion

class MockPedometer: CMPedometer {
    var mockData: CMPedometerData?
    var mockError: Error?
    
    override func startUpdates(from start: Date, withHandler handler: @escaping CMPedometerHandler) {
        if let error = mockError {
            handler(nil, error)
        } else {
            handler(mockData, nil)
        }
    }
    
    override class func isStepCountingAvailable() -> Bool {
        return true
    }
}
