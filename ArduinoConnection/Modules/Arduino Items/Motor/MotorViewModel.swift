//
//  MotorViewModel.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 5/04/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import Foundation

class MotorViewModel {
    var motorOn = false
    
    func filterNumber(number: Int) -> Int {
        var filterNumber = number
        if filterNumber > 255 {
            filterNumber = 255
        }
        return filterNumber
    }

}
