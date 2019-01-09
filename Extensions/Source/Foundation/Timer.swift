//
//  Timer.swift
//  Hubble
//
//  Created by Kyle Begeman on 2/9/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

public extension Timer {
    /// Run the provided block once every specified time interval (delay).
    ///
    /// - Parameters:
    ///   - seconds: the number of seconds to wait for each timer loop.
    ///   - handler: the block to be called when the timer is fired.
    /// - Returns: timer object.
    public static func runEvery(seconds: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }

    /// Run the provided block after the specified time interval (delay).
    ///
    /// - Parameters:
    ///   - seconds: the number of seconds to wait before executing.
    ///   - after: the code block to be called after the delay.
    public static func runAfterDelay(seconds: Double, after: @escaping () -> Void) {
        runAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }

    /// Run the provided block after the specified time interval (delay) in the provided queue.
    ///
    /// - Parameters:
    ///   - seconds: the number of seconds to wait before executing.
    ///   - queue: the queue to run the timer on
    ///   - after: the code block to be called after the delay.
    public static func runAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping () -> Void) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
