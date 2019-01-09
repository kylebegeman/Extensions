//
//  UIFont.swift
//  Hubble
//
//  Created by Kyle Begeman on 2/23/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension UIFont {

    /// Print out font family names, including custom fonts added to the project.
    public class func printFontFamilies() {
        for family in UIFont.familyNames {
            print("")
            print("-----------------------------------")

            let sName: String = family as String
            print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }

}
