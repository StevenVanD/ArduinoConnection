//
//  UICollectionView+Utils.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 21/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//


import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type, forCellWithReuseIdentifier: String) {
        let Nib = UINib(nibName: T.nibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
    }
    
    func cellForRow<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = cellForRow(indexPath as IndexPath) as? T else {
            fatalError("Could not get cell with indexPath: \(indexPath)")
        }
        return cell
    }
    
}
