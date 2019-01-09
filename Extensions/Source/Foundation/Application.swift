//
//  Application.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Properties

public struct Application {

    /// App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    /// App's bundle ID (if applicable).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    /// App current build number (if applicable).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    #if os(iOS) || os(tvOS)
    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    #endif

    /// App's current version (if applicable).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    #if os(iOS) || os(tvOS)
    /// Shared instance of current device.
    public static var currentDevice: UIDevice {
        return UIDevice.current
    }
    #elseif os(watchOS)
    /// Shared instance of current device.
    public static var currentDevice: WKInterfaceDevice {
        return WKInterfaceDevice.current()
    }
    #endif

    /// Screen height.
    public static var screenHeight: CGFloat {
        #if os(iOS)
            return UIScreen.main.bounds.height
        #elseif os(watchOS)
            return currentDevice.screenBounds.height
        #endif
    }

    /// Screen width.
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
            return UIScreen.main.bounds.width
        #elseif os(watchOS)
            return currentDevice.screenBounds.width
        #endif
    }

    /// Current device name.
    public static var deviceName: String {
        return currentDevice.name
    }

    /// Check if app is running in debug mode.
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    #if os(iOS)
    /// Check if multitasking is supported in current device.
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }

    /// Current status bar network activity indicator state.
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }

    /// Check if device is iPhone.
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    /// Check if device is iPad.
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    /// Current orientation of device.
    public static var deviceOrientation: UIDeviceOrientation {
        return currentDevice.orientation
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    #endif

    /// Check if application is running on simulator (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    /// System current version (read-only).
    public static var systemVersion: String {
        return currentDevice.systemVersion
    }
}

// MARK: - Methods

public extension Application {

    /// Delay function or closure call.
    ///
    /// - Parameters:
    ///   - milliseconds: execute closure after the given delay.
    ///   - queue: a queue that completion closure should be executed on (default is DispatchQueue.main).
    ///   - completion: closure to be executed after delay.
    ///   - Returns: DispatchWorkItem task. You can call .cancel() on it to cancel delayed execution.
    @discardableResult public static func delay(milliseconds: Double, queue: DispatchQueue = .main, completion: @escaping () -> Void) -> DispatchWorkItem {
        let task = DispatchWorkItem { completion() }
        queue.asyncAfter(deadline: .now() + (milliseconds/1000), execute: task)
        return task
    }

    /// Delay function or closure call.
    ///
    /// - Parameters:
    ///   - seconds: execute closure after the given delay.
    ///   - queue: a queue that completion closure should be executed on (default is DispatchQueue.main).
    ///   - completion: closure to be executed after delay.
    ///   - Returns: DispatchWorkItem task. You can call .cancel() on it to cancel delayed execution.
    @discardableResult public static func delay(seconds: Double, queue: DispatchQueue = .main, completion: @escaping () -> Void) -> DispatchWorkItem {
        let task = DispatchWorkItem { completion() }
        queue.asyncAfter(deadline: .now() + seconds, execute: task)
        return task
    }

}
