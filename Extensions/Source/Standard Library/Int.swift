//
//  Int.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Int Properties

public extension Int {

    /// Radian value of degree input.
    var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }

    /// Degree value of radian input
    var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }

    /// UInt.
    var uInt: UInt {
        return UInt(self)
    }

    /// Double.
    var double: Double {
        return Double(self)
    }

    /// Float.
    var float: Float {
        return Float(self)
    }

    /// CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self)
    }

}

// MARK: - Int Methods

public extension Int {
    /// Random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random double between two double values.
    static func random(between min: Int, and max: Int) -> Int {
        return random(inRange: min...max)
    }

    /// Random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random double in the given closed range.
    static func random(inRange range: ClosedRange<Int>) -> Int {
        let delta = UInt32(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(arc4random_uniform(delta))
    }

}
