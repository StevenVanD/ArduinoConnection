//
//  ArduinoDetectionTableViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 23/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class ArduinoDetectionTableViewController: UITableViewController {
    
    var viewModel = ArduinoDetectionTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        disconnectFromDevice()
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.centralManager?.stopScan()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.peripherals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlueCell")
        let peripheral = self.viewModel.peripherals[indexPath.row]
        //RSSI = signaalsterkte
        //let RSSI = self.RSSIs[indexPath.row]
        
        
        if peripheral.name == nil {
            cell?.textLabel?.text = "nil"
        } else {
            cell?.textLabel?.text = peripheral.name
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        blePeripheral = viewModel.peripherals[indexPath.row]
        connectToDevice()
    }
    
    func startScan() {
        self.viewModel.timer.invalidate()
        viewModel.centralManager?.scanForPeripherals(withServices: [BLEService_UUID] , options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
        Timer.scheduledTimer(timeInterval: viewModel.scanTime, target: self, selector: #selector(self.cancelScan), userInfo: nil, repeats: false)
    }
    
    @objc func cancelScan() {
        self.viewModel.centralManager?.stopScan()
    }
    
    func connectToDevice () {
        viewModel.centralManager?.connect(blePeripheral!, options: nil)
    }
    
    func disconnectFromDevice () {
        if blePeripheral != nil {
            viewModel.centralManager?.cancelPeripheralConnection(blePeripheral!)
        }
    }
    
    @IBAction func refreshTable(_ sender: UIBarButtonItem) {
        disconnectFromDevice()
        self.viewModel.peripherals = []
        self.viewModel.RSSIs = []
        self.tableView.reloadData()
        startScan()
    }
    
}

extension ArduinoDetectionTableViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            startScan()
        } else {
            let alertVC = UIAlertController(title: "Bluetooth is not enabled", message: "Make sure that your bluetooth is turned on", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "Good to know :D", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.viewModel.peripherals.append(peripheral)
        self.viewModel.RSSIs.append(RSSI)
        peripheral.delegate = self
        peripheral.discoverServices([BLEService_UUID])
        self.tableView.reloadData()
        
        if blePeripheral == nil {
            blePeripheral = peripheral
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        viewModel.centralManager?.stopScan()
        viewModel.data.length = 0
        
        peripheral.delegate = self
        peripheral.discoverServices([BLEService_UUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if ((error) != nil) {
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else {
            return
        }

        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if ((error) != nil) {
            print("Error discovering services: \(error!.localizedDescription)")
            return
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.uuid.isEqual(BLE_Characteristic_uuid_Rx)  {
                rxCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: rxCharacteristic!)
                peripheral.readValue(for: characteristic)
            }
            if characteristic.uuid.isEqual(BLE_Characteristic_uuid_Tx){
                txCharacteristic = characteristic
            }
            peripheral.discoverDescriptors(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic == rxCharacteristic {
            guard let ASCIIstring = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue) else {
                return
            }
            characteristicASCIIValue = ASCIIstring
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "Notify"), object: nil)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("Error discovering services: error")
            return
        }
    }
    
}
