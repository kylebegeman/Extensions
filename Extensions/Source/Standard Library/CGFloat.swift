//
//  CGFloat.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension CGFloat {

    /// Absolute of CGFloat value.
    var abs: CGFloat {
        return Swift.abs(self)
    }

    /// Ceil of CGFloat value.
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// Radian value of degree input.
    var degreesToRadians: CGFloat {
        return CGFloat.pi * self / 180.0
    }

    /// Floor of CGFloat value.
    var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// Check if CGFloat is positive.
    var isPositive: Bool {
        return self > 0
    }

    /// Check if CGFloat is negative.
    var isNegative: Bool {
        return self < 0
    }

    /// Int.
    var int: Int {
        return Int(self)
    }

    /// Float.
    var float: Float {
        return Float(self)
    }

    /// Double.
    var double: Double {
        return Double(self)
    }

    /// Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }

}
