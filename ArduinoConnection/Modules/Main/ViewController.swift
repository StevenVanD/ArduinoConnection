//
//  ViewController.swift
//  ArduinoConnection
//
//  Created by Steven Van Durm on 21/03/18.
//  Copyright © 2018 Steven Van Durm. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var numberOfRows: CGFloat = 0
    private var cellWidth: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfRows = CGFloat(viewModel.numberOfRows)
        collectionView.register(ArduinoItemCollectionViewCell.self, forCellWithReuseIdentifier: "ArduinoItem")
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.layoutIfNeeded()
        updateCollectionViewUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
        collectionView.layoutIfNeeded()
        updateCollectionViewUI()
    }
    
    func updateCollectionViewUI() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        cellWidth = min(collectionView.frame.width * 0.4, collectionView.frame.height * 0.8)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)

        layout.sectionInset.left = (collectionView.frame.width - cellWidth * numberOfRows) / (numberOfRows * 1.5)
        layout.sectionInset.right = (collectionView.frame.width - cellWidth * numberOfRows) / (numberOfRows * 1.5)
    }

    func canPerformSegue(withIdentifier identifier: String) -> Bool {
        guard let identifiers = value(forKey: "storyboardSegueTemplates") as? [NSObject] else {
            return false
        }
        let canPerform = identifiers.contains { (object) -> Bool in
            guard let id = object.value(forKey: "_identifier") as? String else {
                return false
            }
            if id == identifier{
                return true
            } else {
                return false
            }
        }
        return canPerform
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArduinoItem", for: indexPath) as! ArduinoItemCollectionViewCell
        cell.updateUI(withItem: viewModel.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if canPerformSegue(withIdentifier: viewModel.items[indexPath.row].name) {
            performSegue(withIdentifier: viewModel.items[indexPath.row].name, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        updateCollectionViewUI()
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
