//
//  ReminderView.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/22/24.
//

import SwiftUI

struct ReminderView: View {
    
    @State private var content: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var radius: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder Details")) {
                    
                    TextField("Reminder content", text: $content)
                }
                
                Section(header: Text("Location Details")) {
                    
                    TextField("Latitude", text: $latitude)
                        .keyboardType(.decimalPad)
                    
                    TextField("Longitude", text: $longitude)
                        .keyboardType(.decimalPad)
                    
                    TextField("Radius", text: $radius)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button ("Save Reminder") {
                        saveReminder()
                    }
                }
            }
            .navigationTitle("Add Reminder")
        }
    }
    
    func saveReminder() {
        guard let lat = Double(latitude), let lon = Double(longitude), let rad = Double (radius) else {
            return
        }
        
        let newReminder = Reminder(content: content, latitude: lat, longitude: lon, radius: rad)
    }
}

#Preview {
    ReminderView()
}
