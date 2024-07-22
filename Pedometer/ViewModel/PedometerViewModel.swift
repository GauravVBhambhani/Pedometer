//
//  PedometerViewModel.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/21/24.
//

import Foundation
import CoreMotion

class PedometerViewModel: ObservableObject {
    private var pedometer = CMPedometer()
    @Published var steps: Int = 0
    @Published var distance: Double = 0.0
    
    init() {
        startPedometer()
    }
    
    func startPedometer() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] (data, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Pedometer error: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.steps = data?.numberOfSteps.intValue ?? 0
                    if let distance = data?.distance {
                        self.distance = distance.doubleValue
                    }
                }
            }
        } else {
            print("Step counting not available")
        }
    }
}
