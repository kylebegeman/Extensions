//
//  Float.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension Float {

    /// Int.
    public var int: Int {
        return Int(self)
    }

    /// Double.
    public var double: Double {
        return Double(self)
    }

    /// CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }

    /// Check if CGFloat is positive.
    public var isPositive: Bool {
        return self > 0
    }

    /// Check if CGFloat is negative.
    public var isNegative: Bool {
        return self < 0
    }

}
