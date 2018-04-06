//
//  IRSensorViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 30/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class IRSensorViewController: UIViewController, CBPeripheralManagerDelegate {

    @IBOutlet weak var value: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        value.transform = value.transform.scaledBy(x: 1, y: 10)
        updateIncomingData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }
    
    func updateIncomingData () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
            notification in
            let sendedString = (characteristicASCIIValue as String)
            if sendedString.hasPrefix("IR:") {
                let result = sendedString.suffix(from: sendedString.index(sendedString.startIndex, offsetBy: 3))
                guard let resultValue = Int(result) else {
                    return
                }
                self.value.setProgress(Float(min(resultValue-100, 500))/500, animated: true)
            }
            
        }
    }
}
