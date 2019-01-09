//
//  UICollectionViewCell.swift
//  Hubble
//
//  Created by Kyle Begeman on 3/5/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

extension UICollectionViewCell: IdentifiableCell {
    public static var identifier: String {
        return "\(self)"
    }
}
