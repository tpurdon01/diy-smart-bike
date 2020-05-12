//
//  ViewController.swift
//  BluetoothLE
//  iOS 10
//
//  Created by Juan Cruz Guidi on 16/10/16.
//  Copyright © 2016 Juan Cruz Guidi. All rights reserved.
//
import CoreBluetooth

class bleManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject  {

    var manager : CBCentralManager!
    var myBluetoothPeripheral : CBPeripheral!
    var myCharacteristic : CBCharacteristic!
    var characteristicASCIIValue = NSString()
    
    var isMyPeripheralConected = false
    
    func startCentralManager() {
      self.manager = CBCentralManager(delegate: self, queue: nil)
      print("Central Manager State: \(self.manager.state)")
      self.centralManagerDidUpdateState(self.manager)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        var msg = ""
        
        switch central.state {
            case .poweredOff:
                msg = "Bluetooth is Off"
            case .poweredOn:
                msg = "Bluetooth is On"
                self.manager.scanForPeripherals(withServices: nil, options: nil)
            case .unsupported:
                msg = "Not Supported"
            default:
                msg = "😔"
            
        }
        
        print("STATE: " + msg)
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("Name: \(String(describing: peripheral.name))") //print the names of all peripherals connected.
        
        //you are going to use the name here down here ⇩
        
        if peripheral.name == "DSD TECH" { //if is it my peripheral, then connect
            
            self.myBluetoothPeripheral = peripheral     //save peripheral
            self.myBluetoothPeripheral.delegate = self
            
            self.manager?.stopScan()                                     //stop scanning for peripherals
            self.manager.connect(myBluetoothPeripheral, options: nil) //connect to my peripheral
            print("Device connected!")
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isMyPeripheralConected = true //when connected change to true
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isMyPeripheralConected = false //and to falso when disconnected
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if let servicePeripheral = peripheral.services as [CBService]? { //get the services of the perifereal
            
            for service in servicePeripheral {
                
                //Then look for the characteristics of the services
                peripheral.discoverCharacteristics(nil, for: service)
                
            }
            
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if let characterArray = service.characteristics as [CBCharacteristic]? {
            
            for cc in characterArray {
                print(cc.uuid.uuidString)
                if(cc.uuid.uuidString == "FFE1") { //properties: read, write
                                                   //if you have another BLE module, you should print or look for the characteristic you need.
                    
                    myCharacteristic = cc //saved it to send data in another function.
                    peripheral.readValue(for: cc) //to read the value of the characteristic
                    
                }
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if (characteristic.uuid.uuidString == "FFE1") {
                        
            peripheral.setNotifyValue(true, for: characteristic)
                        
            if let ASCIIstring = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue) {
                characteristicASCIIValue = ASCIIstring
                print("Value Recieved: \((characteristicASCIIValue as String))")
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: nil)
            }
            
        }
    }
    
}
