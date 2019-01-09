//
//  Character.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension Character {
    /// Check if character is number.
    ///
    ///        Character("1").isNumber -> true
    ///        Character("a").isNumber -> false
    ///
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }

    /// Check if character is a letter.
    ///
    ///        Character("4").isLetter -> false
    ///        Character("a").isLetter -> true
    ///
    public var isLetter: Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// Check if character is uppercased.
    ///
    ///        Character("a").isUppercased -> false
    ///        Character("A").isUppercased -> true
    ///
    public var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }

    /// Check if character is lowercased.
    ///
    ///        Character("a").isLowercased -> true
    ///        Character("A").isLowercased -> false
    ///
    public var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }

    /// Check if character is white space.
    ///
    ///        Character(" ").isWhiteSpace -> true
    ///        Character("A").isWhiteSpace -> false
    ///
    public var isWhiteSpace: Bool {
        return String(self) == " "
    }

    /// Integer from character (if applicable).
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    public var int: Int? {
        return Int(String(self))
    }

    /// String from character.
    ///
    ///        Character("a").string -> "a"
    ///
    public var string: String {
        return String(self)
    }

}
