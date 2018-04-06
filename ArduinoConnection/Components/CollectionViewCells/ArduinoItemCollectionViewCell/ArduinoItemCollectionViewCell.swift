//
//  ArduinoItemCollectionViewCell.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 21/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import Foundation
import UIKit

class ArduinoItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public func updateUI(withItem item: ArduinoItem){
        nameLabel.text = item.name
        imageView.image = item.image
    }
    
}
