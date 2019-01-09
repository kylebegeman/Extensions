//
//  UIApplication.swift
//  Hubble
//
//  Created by Kyle Begeman on 2/9/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

#if os(iOS) || os(tvOS)

public extension UIApplication {

    /// Get the top most view controller based on the optionally passed in base controller
    ///
    /// - Parameter base: the base controller to check; defaults to the key window's root view controller
    /// - Returns: the top most view controller
    public class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }

}

#endif
