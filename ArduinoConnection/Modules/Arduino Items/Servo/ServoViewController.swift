//
//  ServoViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 30/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class ServoViewController: UIViewController {
    let viewModel = ServoViewModel()

    @IBOutlet weak var valueTextField: NoPasteTextfield!{
        didSet {
            valueTextField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func writeValue(data: String){
        guard let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue), let blePeripheral = blePeripheral, let txCharacteristic = txCharacteristic else {
            return
        }
        blePeripheral.writeValue(valueString, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        valueTextField.resignFirstResponder()
        guard let text = valueTextField.text else {
            return
        }
        writeValue(data: "Servo \(Int(text) ?? 0) \n")
    }

    @IBAction func changeRotation(_ sender: UISlider) {
        writeValue(data: "Servo \(Int(sender.value)) \n")
    }

    @IBAction func textFieldValueChanged(_ sender: NoPasteTextfield) {
        guard let sendedText = sender.text else {
            return
        }
        guard let enteredNumber = Int(sendedText) else {
            return
        }
        valueTextField.text = "\(viewModel.filterNumber(number: enteredNumber))"
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        valueTextField.text = "\(Int(sender.value))"
    }
}

extension ServoViewController: UITextFieldDelegate {
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return true
    }
    
}
