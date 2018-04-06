//
//  LedViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 22/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class LedViewController: UIViewController{
    
    @IBOutlet weak var led3ImageView: UIImageView!
    @IBOutlet weak var led2ImageView: UIImageView!
    @IBOutlet weak var led1ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func writeValue(data: String){
        guard let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue), let blePeripheral = blePeripheral, let txCharacteristic = txCharacteristic else {
            return
        }
        blePeripheral.writeValue(valueString, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
    
    @IBAction func switchedLed(_ sender: UISwitch) {
        if sender.isOn {
            switch sender.tag {
            case 1 :
            led1ImageView.backgroundColor = UIColor.green
            case 2 :
            led2ImageView.backgroundColor = UIColor.red
            case 3 :
            led3ImageView.backgroundColor = UIColor.red
            default: break
            }
            writeValue(data: "led\(sender.tag) true")
        } else {
            writeValue(data: "led\(sender.tag) false")
            switch sender.tag {
            case 1 :
            led1ImageView.backgroundColor = UIColor.white
            case 2 :
            led2ImageView.backgroundColor = UIColor.white
            case 3 :
            led3ImageView.backgroundColor = UIColor.white
            default: break
            }
        }
    }
}
