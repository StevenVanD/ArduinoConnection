//
//  UIView+Loadable.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 21/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView { }

extension UICollectionViewCell: NibLoadableView { }
