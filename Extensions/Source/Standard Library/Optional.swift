//
//  Optional.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension Optional {

    /// True if the Optional is .None. Useful to avoid if-let.
    var isNil: Bool {
        if case .none = self {
            return true
        }

        return false
    }

    /// Get self of default value (if self is nil).
    ///
    ///        let foo: String? = nil
    ///        print(foo.unwrapped(or: "bar")) -> "bar"
    ///
    ///        let bar: String? = "bar"
    ///        print(bar.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    public func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        // http://www.russbishop.net/improving-optionals
        return self ?? defaultValue
    }

    /// Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Returns: The value wrapped by the optional.
    /// - Throws: The error passed in.
    public func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }

    /// Runs a block to Wrapped if not nil
    ///
    ///        let foo: String? = nil
    ///        foo.run { unwrappedFoo in
    ///            // block will never run sice foo is nill
    ///            print(unwrappedFoo)
    ///        }
    ///
    ///        let bar: String? = "bar"
    ///        bar.run { unwrappedBar in
    ///            // block will run sice bar is not nill
    ///            print(unwrappedBar) -> "bar"
    ///        }
    ///
    /// - Parameter block: a block to run if self is not nil.
    public func run(_ block: (Wrapped) -> Void) {
        // http://www.russbishop.net/improving-optionals
        _ = self.map(block)
    }

}
