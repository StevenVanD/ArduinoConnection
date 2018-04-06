//
//  ArduinoDetectionTableViewModel.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 5/04/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import Foundation
import CoreBluetooth

var blePeripheral : CBPeripheral?
var txCharacteristic : CBCharacteristic?
var rxCharacteristic : CBCharacteristic?
var characteristicASCIIValue = NSString()

class ArduinoDetectionTableViewModel {
    
    var centralManager: CBCentralManager!
    var timer = Timer()
    var RSSIs = [NSNumber]()
    var peripherals: [CBPeripheral] = []
    var data = NSMutableData()
    var scanTime: TimeInterval = 17
    
}
