//
//  ViewModel.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 21/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import Foundation

class ViewModel {
    var items: [ArduinoItem] = [
        ArduinoItem(name: "leds", imageName: "led"),
        ArduinoItem(name: "motor", imageName: "motor"),
        ArduinoItem(name: "servo", imageName: "servo"),
        ArduinoItem(name: "buzzer", imageName: "buzzer"),
        ArduinoItem(name: "potentiometer", imageName: "potentiometer"),
        ArduinoItem(name: "IRSensor", imageName: "IRSensor"),
        ArduinoItem(name: "car", imageName: "car")
    ]
    
    let numberOfRows = 2
}
