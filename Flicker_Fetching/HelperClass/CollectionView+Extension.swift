//
//  CollectionView+Extension.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation
import UIKit


extension UICollectionView {

    /// Registers a cell using its nib name and sets the delegate and dataSource.
    ///
    /// - Parameters:
    ///   - cellIdentifier: The identifier and nib name of the cell to register.
    ///   - target: The object that conforms to `UICollectionViewDelegate` and `UICollectionViewDataSource`.
    func setCollectionView<T>(_ cellIdentifier: String, target: T) {

        // Register the nib file for the specified cell identifier
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)

        // Assign delegate and dataSource if target conforms to the required protocols
        self.delegate = target as? UICollectionViewDelegate
        self.dataSource = target as? UICollectionViewDataSource
    }

}

