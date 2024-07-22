//
//  ContentView.swift
//  Pedometer
//
//  Created by Gaurav Bhambhani on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PedometerViewModel()
    
    var body: some View {
        VStack {
            Text("Steps: \(viewModel.steps)")
                .font(.largeTitle)
                .padding()
            
            Text(String(format: "Distance: %.2f meters", viewModel.distance))
                .font(.title)
                .padding()
        }
        .onAppear {
            viewModel.startPedometer()
        }
    }
}


#Preview {
    ContentView()
}
