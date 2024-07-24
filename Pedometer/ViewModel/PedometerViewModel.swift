//
//  PedometerViewModel.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/21/24.
//

import Foundation
import CoreMotion

class PedometerViewModel: ObservableObject {
    
    private var pedometerModel = PedometerModel()
    
    @Published var steps: Int = 0
    @Published var distance: Double = 0.0
    @Published var errorMessage: String? = nil
    
    init() {
        startPedometer()
    }
    
//    func startPedometer() {
//        pedometerModel.startPedometerUpdates{ [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data):
//                    self?.steps = data.steps
//                    self?.distance = data.distance
//                    
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
    
    func startPedometer() {
        Task {
            do {
                let data = try await pedometerModel.startPedometerUpdates()
                DispatchQueue.main.async {
                    self.steps = data.steps
                    self.distance = data.distance
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
