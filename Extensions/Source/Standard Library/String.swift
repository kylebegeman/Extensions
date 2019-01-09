//
//  String.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension String {

    /// Safely subscript string with index.
    ///
    ///        "Hello World!"[3] -> "l"
    ///        "Hello World!"[20] -> nil
    ///
    /// - Parameter i: index.
    public subscript(safe i: Int) -> Character? {
        guard i >= 0 && i < count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }

    /// Safely subscript string within a half-open range.
    ///
    ///        "Hello World!"[6..<11] -> "World"
    ///        "Hello World!"[21..<110] -> nil
    ///
    /// - Parameter range: Half-open range.
    public subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    /// Safely subscript string within a closed range.
    ///
    ///        "Hello World!"[6...11] -> "World!"
    ///        "Hello World!"[21...110] -> nil
    ///
    /// - Parameter range: Closed range.
    public subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    /// Check if string contains one or more instance of substring.
    ///
    ///        "Hello World!".contain("O") -> false
    ///        "Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }

    /// Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }

    /// Check if string starts with substring.
    ///
    ///        "hello World".starts(with: "h") -> true
    ///        "hello World".starts(with: "H", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }

    /// Check if string ends with substring.
    ///
    ///        "Hello World!".ends(with: "!") -> true
    ///        "Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }

    /// Get the needed width based on height constraints for this string.
    ///
    /// - Parameters:
    ///   - height: the fixed height the string will use to caluclate bounds.
    ///   - font: the font of the label; different fonts have different sizes.
    /// - Returns: CGFloat value with the needed width.
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        return self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).width
    }

    /// Get the needed height based on width constraints for this string.
    ///
    /// - Parameters:
    ///   - width: the fixed width the string will use to caluclate bounds.
    ///   - font: the font of the label; different fonts have different sizes.
    /// - Returns: CGFloat value with the needed height.
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        return self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).height
    }

    /// Count of substring in string.
    ///
    ///        "Hello World!".count(of: "o") -> 2
    ///        "Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }

    /// Check if string is valid email format.
    ///
    ///        "john@doe.com".isEmail -> true
    ///
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }

    /// URL from string (if applicable).
    ///
    ///        "https://google.com".url -> URL(string: "https://google.com")
    ///        "not url".url -> nil
    ///
    public var url: URL? {
        return URL(string: self)
    }

    /// Check if string is a valid URL.
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }

    /// Check if string is a valid schemed URL.
    ///
    ///        "https://google.com".isValidSchemedUrl -> true
    ///        "google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }

    /// Check if string is a valid https URL.
    ///
    ///        "https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }

    /// Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }

    /// Check if string contains only numbers.
    ///
    ///        "123".isNumeric -> true
    ///        "abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return !hasLetters && hasNumbers
    }

    /// Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    public var int: Int? {
        return Int(self)
    }

    /// String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    /// URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    /// Array of characters of a string.
    public var charactersArray: [Character] {
        return Array(self)
    }

    /// Random string of given length.
    ///
    ///        String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    public static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            let randomCharacter = base.charactersArray[Int(randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }

    /// Create a new random string of given length.
    ///
    ///        String(randomOfLength: 10) -> "gY8r3MHvlQ"
    ///
    /// - Parameter length: number of characters in string.
    public init(randomOfLength length: Int) {
        self = String.random(ofLength: length)
    }

    /// Lorem ipsum string of given length.
    ///
    /// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
    /// - Returns: Lorem ipsum dolor sit amet... string.
    public static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }

        // https://www.lipsum.com/
        let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        if loremIpsum.count > length {
            return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
        }
        return loremIpsum
    }

    /// Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    /// First character of string (if applicable).
    ///
    ///        "Hello".firstCharacterAsString -> Optional("H")
    ///        "".firstCharacterAsString -> nil
    ///
    public var firstCharacterAsString: String? {
        guard let first = first else { return nil }
        return String(first)
    }

    /// Last character of string (if applicable).
    ///
    ///        "Hello".lastCharacterAsString -> Optional("o")
    ///        "".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = last else { return nil }
        return String(last)
    }

    /// Transforms the string into a slug string.
    ///
    ///        "Swift is amazing".toSlug() -> "swift-is-amazing"
    ///
    /// - Returns: The string in slug format.
    public func toSlug() -> String {
        let lowercased = self.lowercased()
        let withDashes = lowercased.replacingOccurrences(of: " ", with: "-")

        let alphanumerics = NSCharacterSet.alphanumerics
        var filtered = withDashes.filter {
            guard String($0) != "-" else { return true }
            guard String($0) != "&" else { return true }
            return String($0).rangeOfCharacter(from: alphanumerics) != nil
        }

        while filtered.lastCharacterAsString == "-" {
            filtered = String(filtered.dropLast())
        }

        while filtered.firstCharacterAsString == "-" {
            filtered = String(filtered.dropFirst())
        }

        return filtered.replacingOccurrences(of: "--", with: "-")
    }

    /// An array of all words in a string
    ///
    ///        "Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    /// - Returns: The words contained in a string.
    public func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }

    /// Count of words in a string.
    ///
    ///        "Swift is amazing".wordsCount() -> 3
    ///
    /// - Returns: The count of words contained in a string.
    public func wordCount() -> Int {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        let words = comps.filter { !$0.isEmpty }
        return words.count
    }

    /// Converts string format to CamelCase.
    ///
    ///        var str = "sOme vaRiabLe Name"
    ///        str.camelize()
    ///        print(str) // prints "someVariableName"
    ///
    public mutating func camelize() {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            self = first + rest
            return
        }
        let rest = String(source.dropFirst())

        self = first + rest
    }

    /// Check if string contains only unique characters.
    public func hasUniqueCharacters() -> Bool {
        guard count > 0 else { return false }
        var uniqueChars = Set<String>()
        for char in self {
            if uniqueChars.contains(String(char)) { return false }
            uniqueChars.insert(String(char))
        }
        return true
    }

    /// Truncate string (cut it to a given number of characters).
    ///
    ///        var str = "This is a very long sentence"
    ///        str.truncate(toLength: 14)
    ///        print(str) // prints "This is a very..."
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    public mutating func truncate(toLength length: Int, trailing: String? = "...") {
        guard length > 0 else { return }
        if count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
    }

    /// Truncated string (limited to a given number of characters).
    ///
    ///        "This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
    ///        "Short sentence".truncated(toLength: 14) -> "Short sentence"
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    public func truncated(toLength length: Int, trailing: String? = "...") -> String {
        guard 1..<count ~= length else { return self }
        return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
    }

    /// Convert URL string to readable string.
    ///
    ///        var str = "it's%20easy%20to%20decode%20strings"
    ///        str.urlDecode()
    ///        print(str) // prints "it's easy to decode strings"
    ///
    public mutating func urlDecode() {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
    }

    /// Escape string.
    ///
    ///        var str = "it's easy to encode strings"
    ///        str.urlEncode()
    ///        print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    public mutating func urlEncode() {
        if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            self = encoded
        }
    }

}

// MARK: - NSString extensions

public extension String {

    /// NSString from a string.
    public var nsString: NSString {
        return NSString(string: self)
    }

    /// NSString pathExtension.
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    /// NSString deletingLastPathComponent.
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    /// NSString deletingPathExtension.
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    /// NSString pathComponents.
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }

    /// NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    /// NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }

}
