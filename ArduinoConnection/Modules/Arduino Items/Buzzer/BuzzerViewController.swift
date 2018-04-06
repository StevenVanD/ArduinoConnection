//
//  BuzzerViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 29/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class BuzzerViewController: UIViewController {

    @IBOutlet weak var notesStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetBuzzer(_ sender: UIButton) {
        writeValue(data: "buzzer Reset")
    }
    
    @IBAction func playANote(_ sender: UIButton) {
        guard let note: String = sender.restorationIdentifier else {
            return
        }
        writeValue(data: "buzzer \(note)")

    }

    func writeValue(data: String){
        guard let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue), let blePeripheral = blePeripheral, let txCharacteristic = txCharacteristic else {
            return
        }
        blePeripheral.writeValue(valueString, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
}
