//
//  UITableViewCell.swift
//  Hubble
//
//  Created by Kyle Begeman on 3/5/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

/// Simple protocol for generic typing
public protocol IdentifiableCell: class {
    static var identifier: String { get }
}

extension UITableViewCell: IdentifiableCell {
    /// The xib identifier to be used; should match the class name.
    public static var identifier: String {
        return "\(self)"
    }
}
