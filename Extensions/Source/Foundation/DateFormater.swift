//
//  DateFormatter.swift
//  Hubble
//
//  Created by Kyle Begeman on 5/7/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

/// Simple enum to manage multiple date formats
public enum DateFormat {
    case short
    case medium
    case large

    var formatString: String {
        switch self {
        case .short:    return "M/d"
        case .medium:   return "yyyy-MM-dd"
        case .large:    return "yyyy-MM-dd'T'HH:mm:ss.000Z"
        }
    }

    var timeZone: TimeZone {
        // Update on a per case basis when needed.
        return TimeZone.autoupdatingCurrent
    }

    var locale: Locale {
        // Update on a per case basis when needed.
        return Locale(identifier: "en_US_POSIX")
    }
}

/// Simple extension to inject DateFormat object for easier management of string formatting dates.
///
/// Ex:
///
///     DateFormatter().string(from: Date(), format: .standard)
public extension DateFormatter {

    /// Return the string object based on the passed in date an format object.
    ///
    /// - Parameters:
    ///   - date: date to be converted to string.
    ///   - format: the format to define the string outout.
    /// - Returns: a string representation of the passed in date object.
    func string(from date: Date, format: DateFormat) -> String {
        self.timeZone = format.timeZone
        self.dateFormat = format.formatString
        self.locale = format.locale

        return self.string(from: date)
    }

    /// Return a date object based on the provided string.
    ///
    /// - Parameter string: string to match the date forat.
    /// - Returns: Date object.
    func date(from string: String, format: DateFormat) -> Date? {
        self.timeZone = format.timeZone
        self.dateFormat = format.formatString
        self.locale = format.locale

        return self.date(from: string)
    }
}
