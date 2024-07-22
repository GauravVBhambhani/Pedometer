//
//  ReminderModel.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/22/24.
//

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
    let content: String
    let latitude: Double
    let longitude: Double
    let radius: Double
}
