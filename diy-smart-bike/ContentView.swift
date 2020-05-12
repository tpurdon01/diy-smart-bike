//
//  ContentView.swift
//  diy-smart-bike
//
//  Created by Tom Purdon on 10/05/2020.
//  Copyright © 2020 TomPurdon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var ble = bleManager()
    @ObservedObject var viewModel = BikeViewModel()
    @ObservedObject var stopWatch = StopWatch()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            StopWatchView(ble: self.ble, stopWatch: self.stopWatch)
            Divider()
            VStack (spacing: 5) {
                Text("Time: ")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding()
                Text(self.stopWatch.stopWatchTime)
                    .font(.largeTitle)
                    .bold()
            }
            Divider()
            BikeView(viewModel: self.viewModel)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
