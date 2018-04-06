//
//  ServoViewModel.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 6/04/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import Foundation

class ServoViewModel {
    func filterNumber(number: Int) -> Int {
        var filterNumber = number
        if filterNumber > 180 {
            filterNumber = 180
        }
        return filterNumber
    }
}
