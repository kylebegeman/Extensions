//
//  UIViewController.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/23/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension UIViewController {

    /// Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }

}

// MARK: - Methods

public extension UIViewController {

    /// Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// Unassign as listener from all notifications.
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    /// Add child view controller and handle all containment method calls.
    ///
    /// - Parameter child: the child view controller to add.
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }

    /// Remove from the parrent view controller; will manage all containment method calls.
    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }

    /// Pushes a view controller onto the receiver’s stack and updates the display.
    public func push(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

    /// Pops the top view controller from the navigation stack and updates the display.
    public func pop() {
        _ = navigationController?.popViewController(animated: true)
    }

    /// Added extension for popToRootViewController
    public func popToRoot() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    /// Presents a view controller modally.
    public func present(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }

    /// Dismisses the view controller that was presented modally by the view controller.
    public func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

}
