//
//  Array.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Methods

public extension Array {

    /// Element at the given index if it exists.
    ///
    ///        [1, 2, 3, 4, 5].item(at: 2) -> 3
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].item(at: 3) -> 3.4
    ///        ["h", "e", "l", "l", "o"].item(at: 10) -> nil
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    func item(at index: Int) -> Element? {
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }

    /// Safely Swap values at index positions.
    ///
    ///        [1, 2, 3, 4, 5].safeSwap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    ///        ["h", "e", "l", "l", "o"].safeSwap(from: 1, to: 0) -> ["e", "h", "l", "l", "o"]
    ///
    /// - Parameters:
    ///   - index: index of first element.
    ///   - otherIndex: index of other element.
    mutating func safeSwap(from index: Int, to otherIndex: Int) {
        guard index != otherIndex,
            startIndex..<endIndex ~= index,
            startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }

    /// Get first index where condition is met.
    ///
    ///        [1, 7, 1, 2, 4, 1, 6].firstIndex { $0 % 2 == 0 } -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: first index where the specified condition evaluates to true. (optional)
    func firstIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated() {
            if try condition(value) { return index }
        }
        return nil
    }

    /// Get last index where condition is met.
    ///
    ///     [1, 7, 1, 2, 4, 1, 8].lastIndex { $0 % 2 == 0 } -> 6
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: last index where the specified condition evaluates to true. (optional)
    func lastIndex(where condition: (Element) throws -> Bool) rethrows -> Int? {
        for (index, value) in lazy.enumerated().reversed() {
            if try condition(value) { return index }
        }
        return nil
    }

    /// SwifterSwift: Get element count based on condition.
    ///
    ///        [2, 2, 4, 7].count(where: {$0 % 2 == 0}) -> 3
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: number of times the condition evaluated to true.
    func count(where condition: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try condition(element) { count += 1 }
        }
        return count
    }

    /// Check if all elements in array match a conditon.
    ///
    ///        [2, 2, 4].all(matching: {$0 % 2 == 0}) -> true
    ///        [1,2, 2, 4].all(matching: {$0 % 2 == 0}) -> false
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when all elements in the array match the specified condition.
    func all(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try !condition($0) }
    }

    /// Check if no elements in array match a conditon.
    ///
    ///        [2, 2, 4].none(matching: {$0 % 2 == 0}) -> false
    ///        [1, 3, 5, 7].none(matching: {$0 % 2 == 0}) -> true
    ///
    /// - Parameter condition: condition to evaluate each element against.
    /// - Returns: true when no elements in the array match the specified condition.
    func none(matching condition: (Element) throws -> Bool) rethrows -> Bool {
        return try !contains { try condition($0) }
    }

    /// Iterate over a collection in reverse order. (right to left)
    ///
    ///        [0, 2, 4, 7].forEachReversed({ print($0)}) -> //Order of print: 7,4,2,0
    ///
    /// - Parameter body: a closure that takes an element of the array as a parameter.
    func forEachReversed(_ body: (Element) throws -> Void) rethrows {
        try reversed().forEach { try body($0) }
    }

    /// Calls given closure with each element where condition is true.
    ///
    ///        [0, 2, 4, 7].forEach(where: {$0 % 2 == 0}, body: { print($0)}) -> //print: 0, 2, 4
    ///
    /// - Parameters:
    ///   - condition: condition to evaluate each element against.
    ///   - body: a closure that takes an element of the array as a parameter.
    func forEach(where condition: (Element) throws -> Bool, body: (Element) throws -> Void) rethrows {
        for element in self where try condition(element) {
            try body(element)
        }
    }

}

// MARK: - Numeric

public extension Array where Element: Numeric {

    /**
     Sum of all elements in array.

     [1, 2, 3, 4, 5].sum() -> 15

     - Returns: sum of the array's elements.
     */
    func sum() -> Element {
        var total: Element = 0
        for i in 0..<count {
            total += self[i]
        }
        return total
    }

}

public extension Array where Element: FloatingPoint {

    /// Average of all elements in array.
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Element {
        guard !isEmpty else { return 0 }
        var total: Element = 0
        for i in 0..<count {
            total += self[i]
        }
        return total / Element(count)
    }

}

// MARK: - Equatable

public extension Array where Element: Equatable {

    /// Check if array contains an array of elements.
    ///
    ///        [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: array of elements to check.
    /// - Returns: true if array contains all given items.
    func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { return true }
        var found = true
        for element in elements {
            if !contains(element) {
                found = false
            }
        }
        return found
    }

    /// Remove all instances of an item from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll(2) -> [1, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"].removeAll("l") -> ["h", "e", "o"]
    ///
    /// - Parameter item: item to remove.
    mutating func removeAll(_ item: Element) {
        self = filter { $0 != item }
    }

    /// Remove all instances contained in items parameter from array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeAll([2,5]) -> [1, 3, 4]
    ///        ["h", "e", "l", "l", "o"].removeAll(["l", "h"]) -> ["e", "o"]
    ///
    /// - Parameter items: items to remove.
    mutating func removeAll(_ items: [Element]) {
        guard !items.isEmpty else { return }
        self = filter { !items.contains($0) }
    }

    /// Remove all duplicate elements from Array.
    ///
    ///        [1, 2, 2, 3, 4, 5].removeDuplicates() -> [1, 2, 3, 4, 5]
    ///        ["h", "e", "l", "l", "o"]. removeDuplicates() -> ["h", "e", "l", "o"]
    ///
    mutating func removeDuplicates() {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

    /// SwifterSwift: Return array with all duplicate elements removed.
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].duplicatesRemoved() -> [1, 2, 3, 4, 5])
    ///     ["h", "e", "l", "l", "o"].duplicatesRemoved() -> ["h", "e", "l", "o"])
    ///
    /// - Returns: an array of unique elements.
    ///
    func duplicatesRemoved() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the property
        return reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }

}
