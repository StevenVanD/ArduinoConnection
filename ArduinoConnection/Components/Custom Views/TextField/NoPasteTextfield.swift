//
//  PasteLessTextfield.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 4/04/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit

class NoPasteTextfield: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        DispatchQueue.main.async(execute: {
            (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
        })
        return false
    }

}
