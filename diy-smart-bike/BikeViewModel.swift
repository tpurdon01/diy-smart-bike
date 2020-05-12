//
//  BikeViewModel.swift
//  diy-smart-bike
//
//  Created by Tom Purdon on 10/05/2020.
//  Copyright © 2020 TomPurdon. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreFoundation
import SwiftUI
import Combine

class BikeViewModel: ObservableObject {
    
    @Published var pedalCount = 0;
    @Published var Pi = 3.14159265359;
    @Published var bikeRadius = 0.55;
    @Published var distance = 0.0;
    @Published var speed = 0.0;
    var startPedalTime:CFAbsoluteTime = 0
    var pedalDuration:CFAbsoluteTime? = 0

    func updateIncomingData () {
     NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
     notification in
            
        self.pedalCount += 1;
        if(self.pedalCount == 1){
            self.startPedalTime = CFAbsoluteTimeGetCurrent()
        }
        
        self.pedalDuration = CFAbsoluteTimeGetCurrent() - self.startPedalTime
        self.startPedalTime = CFAbsoluteTimeGetCurrent()
        
        self.distance = (2.0 * self.Pi * self.bikeRadius * Double( self.pedalCount )) / 1000.0 //calculate distance in km
        
        self.speed = (2.0 * self.Pi * self.bikeRadius / (self.pedalDuration!)) * 3.6 // calculate the average speed m/s
                
        }
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }

    //Check when someone subscribe to our characteristic, start sending the data
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}
