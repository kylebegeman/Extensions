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
    public var abs: CGFloat {
        return Swift.abs(self)
    }

    /// Ceil of CGFloat value.
    public var ceil: CGFloat {
        return Foundation.ceil(self)
    }

    /// Radian value of degree input.
    public var degreesToRadians: CGFloat {
        return CGFloat.pi * self / 180.0
    }

    /// Floor of CGFloat value.
    public var floor: CGFloat {
        return Foundation.floor(self)
    }

    /// Check if CGFloat is positive.
    public var isPositive: Bool {
        return self > 0
    }

    /// Check if CGFloat is negative.
    public var isNegative: Bool {
        return self < 0
    }

    /// Int.
    public var int: Int {
        return Int(self)
    }

    /// Float.
    public var float: Float {
        return Float(self)
    }

    /// Double.
    public var double: Double {
        return Double(self)
    }

    /// Degree value of radian input.
    public var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }

}
