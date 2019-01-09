//
//  UIStoryboard.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// Stroybaord extension
public extension UIStoryboard {

    /// Get main storyboard for application
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

    /// Custom initializer for 'Storyboard' protocol conformance
    ///
    /// - Parameters:
    ///   - storyboard: 'Storyboard' object to initialize
    ///   - bundle: The project bundle; default is nil
    public convenience init(storyboard: StoryboardNameable, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }

    /// Initialize view controller based on StoryboardIdentafiable conformance
    ///
    ///         let controller: SomeController = aStoryboad.instantiateViewController()
    ///
    /// - Returns: T (generic value)
    public func instantiateViewController<T: StoryboardIdentifiable>() -> T {
        guard let controller = self.instantiateViewController(withIdentifier: T.storyboardId) as? T else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardId)")
        }

        return controller
    }

    /// Creates and returns a storyboard object for the specified storyboard resource file in the main bundle of the current application.
    ///
    /// - Parameter name: The name of the storyboard resource file without the filename extension.
    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
}
