//
//  UILabel.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/23/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Methods

public extension UILabel {

    /// Initialize a UILabel with text
    convenience init(text: String?) {
        self.init()
        self.text = text
    }

    /// Required height for a label
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }

}
