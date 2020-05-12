//
//  StopWatchView.swift
//  diy-smart-bike
//
//  Created by Tom Purdon on 12/05/2020.
//  Copyright © 2020 TomPurdon. All rights reserved.
//

import SwiftUI

struct StopWatchView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var ble: bleManager
    @ObservedObject var stopWatch: StopWatch
    @State private var isConnected:Bool = false
    @State private var isActive:Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.ble.startCentralManager()
                self.isConnected = true
            }) {
                HStack {
                    Image(systemName: "link")
                        .font(.title)
                    if isConnected == false {
                        Text("Pair Device")
                            .font(.title)
                    } else {
                        Text("Device Paired")
                            .font(.subheadline)
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkBlue"), Color("LightBlue")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(50)
                .foregroundColor(.white)
            }
            
            if isActive == false {
                Button(action: {
                    self.isActive = true
                    self.stopWatch.start()
                }) {
                    HStack {
                        Image(systemName: "play")
                            .font(.title)
                        Text("Start Workout")
                            .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                    .cornerRadius(50)
                    .foregroundColor(.white)
                }
            } else {
                HStack {
                    if self.stopWatch.isPaused() == false {
                        Button(action: {
                            self.stopWatch.pause()
                        }) {
                            HStack {
                                Image(systemName: "pause")
                                    .font(.title)
                                Text("Pause Workout")
                                    .font(.title)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(50)
                            .foregroundColor(.white)
                        }
                    } else {
                        Button(action: {
                            self.isActive = true
                            self.stopWatch.start()
                        }) {
                            HStack {
                                Image(systemName: "play")
                                    .font(.title)
                                Text("Resume Workout")
                                    .font(.title)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                            .cornerRadius(50)
                            .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        self.stopWatch.pause()
                        self.stopWatch.reset()
                        self.isActive = false
                    }) {
                        HStack {
                            Image(systemName: "stop")
                                .font(.title)
                            Text("End Workout")
                                .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color("DarkRed"), Color("LightRed")]), startPoint: .bottomLeading, endPoint: .topTrailing))                        .cornerRadius(50)
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
