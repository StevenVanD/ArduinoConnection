//
//  MotorViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 29/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class MotorViewController: UIViewController {

    let viewModel = MotorViewModel()
    var button = UIButton()
    
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var valueTextField: UITextField!{
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
        writeValue(data: "Motor \(Int(text) ?? 0) \n")
    }
    
    @IBAction func changedSliderPosition(_ sender: UISlider) {
        valueTextField.text = "\(Int(sender.value))"
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        writeValue(data: "Motor \(Int(sender.value)) \n")
        valueTextField.text = "\(Int(sender.value))"
    }
    
    @IBAction func switchMotorState(_ sender: UISwitch) {
        viewModel.motorOn = sender.isOn
        if viewModel.motorOn == false {
            writeValue(data: "Motor off")
        } else {
            writeValue(data: "Motor on")
        }
    }
    
    @IBAction func textfieldValueChanged(_ sender: NoPasteTextfield) {
        guard let sendedText = sender.text else {
            return
        }
        guard let enteredNumber = Int(sendedText) else {
            return
        }
        valueTextField.text = "\(viewModel.filterNumber(number: enteredNumber))"
    }
    
}
extension MotorViewController: UITextFieldDelegate {

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return true
    }

}
