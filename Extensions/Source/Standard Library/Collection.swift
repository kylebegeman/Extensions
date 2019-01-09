//
//  Collection.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension Collection {

    /// Safe protects the array from out of bounds by use of optional.
    ///
    ///        let arr = [1, 2, 3, 4, 5]
    ///        arr[safe: 1] -> 2
    ///        arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

public extension Collection where Index == Int {

    /// Random item from array.
    public var randomItem: Iterator.Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

}
