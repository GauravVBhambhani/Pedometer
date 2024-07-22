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
    
    // modifying PedometerModel to accept a (mock)CMPedometer instance through initializer. (Dependency Injection)
    
    init(pedometer: CMPedometer = CMPedometer()) {
        self.pedometer = pedometer
    }
    
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
