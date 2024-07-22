//
//  PedometerModel.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/22/24.
//

import Foundation
import CoreMotion

class PedometerModel {
    
    private var pedometer = CMPedometer()
    
    func startPedometerUpdates(completion: @escaping (Result<(steps: Int, distance: Double), Error>) -> Void) {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { data, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let steps = data?.numberOfSteps.intValue ?? 0
                    let distance = data?.distance?.doubleValue ?? 0.0
                    completion(.success((steps, distance)))
                }
            }
        } else {
            completion(.failure(NSError(domain: "Pedometer", code: 0, userInfo: [NSLocalizedDescriptionKey: "step count not available"])))
        }
    }
}
