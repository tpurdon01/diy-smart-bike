//
//  BikeView.swift
//  diy-smart-bike
//
//  Created by Tom Purdon on 10/05/2020.
//  Copyright © 2020 TomPurdon. All rights reserved.
//

import SwiftUI

struct BikeView: View {
    
    @ObservedObject var viewModel: BikeViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text("Speed: ")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Text("\(self.viewModel.speed, specifier: "%.2f")")
                    .font(.largeTitle)
                    .bold()
            }
            Divider()
            VStack(spacing: 5) {
                Text("Distance: ")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Text("\(self.viewModel.distance, specifier: "%.2f")")
                    .font(.largeTitle)
                    .bold()
            }
            Divider()
        }
        .onAppear {
            self.viewModel.updateIncomingData()
        }
    }
    
}
