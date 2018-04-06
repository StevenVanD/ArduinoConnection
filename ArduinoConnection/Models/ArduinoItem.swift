//
//  ArduinoItem.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 22/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit

class ArduinoItem {
    var name : String!
    var image = #imageLiteral(resourceName: "question")
    init(name: String, imageName: String) {
        self.name = name
        guard let image = UIImage(named: imageName) else {
            return
        }
        self.image = image

    }
}
