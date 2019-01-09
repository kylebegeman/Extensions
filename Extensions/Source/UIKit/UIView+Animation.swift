//
//  UIView+Animation.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/7/19.
//  Copyright © 2019 Kyle Begeman. All rights reserved.
//

import Foundation

public extension UIView {

    /// Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    public enum ShakeDirection {
        case horizontal /// Shake left and right.
        case vertical   /// Shake up and down.
    }

    /// Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    public enum AngleUnit {
        case degrees /// degrees.
        case radians /// radians.
    }

    /// Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    public enum ShakeAnimationType {
        case linear     /// linear animation.
        case easeIn     /// easeIn animation.
        case easeOut    /// easeOut animation.
        case easeInOut  /// easeInOut animation.
    }

    /// Rotate view by angle on relative axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view by.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }

    /// Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }

    /// Scale view by offset.
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }

    /// Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    public func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
        CATransaction.begin()

        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:   animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:     animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }

        switch animationType {
        case .linear:       animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        case .easeIn:       animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        case .easeOut:      animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        case .easeInOut:    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }

        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]

        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }

}

// MARK: - System animation repalcement.

public extension UIView {

    /// UIView based class for performing animations with method chaining for simpler syntax
    ///
    ///     UIView.Animator(animationType: .regular(duration: 2.0, delay: 0.0, options: []))
    ///     .animations {
    ///         // Perform animations.
    ///     }
    ///     .completion { complete in
    ///         // Completion tasks.
    ///     }
    ///     .animate() // Start animations.
    ///
    public class Animator {
        /// Store completion types for the animator.
        public typealias Completion = (Bool) -> Void
        public typealias Animations = () -> Void

        // MARK: - Private stuff

        /// Animation types to allow for regular or spring animations.
        ///
        /// - regular: regular, or, linear animation
        /// - spring: spring based animation with velocity and bounce.
        public enum AnimationType {
            case regular(duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions)
            case spring(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions)
        }

        /// Local properties for managing animation
        private let animationType: AnimationType
        private var animations: Animations = {}
        private var completion: Completion? = nil

        ///  Main initializer that accepts an animation type option.
        ///
        /// - Parameter animationType: the animation type to perform.
        public init(animationType: AnimationType) {
            self.animationType = animationType
        }

        /// Convenience initializer for Apple SDK continuity.
        public convenience init(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = []) {
            self.init(animationType: .regular(duration: duration, delay: delay, options: options))
        }

        /// Convenience initializer for Apple SDK continuity.
        public convenience init(duration: TimeInterval, delay: TimeInterval = 0, damping: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions = []) {
            self.init(animationType: .spring(duration: duration, delay: delay, damping: damping, velocity: velocity, options: options))
        }

        /// Define the animations to be performed. Returns self to allow for chained method callings.
        ///
        /// - Parameter animations: the animation to perform.
        /// - Returns: an instance of self to allow for chained method calls.
        public func animations(_ animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }

        /// Define the completion block using chained methods.
        ///
        /// - Parameter completion: the completion block to be called on completion.
        /// - Returns: an instance of self to allow for changed method calls.
        public func completion(_ completion: Completion?) -> Self {
            self.completion = completion
            return self
        }

        /// Perform the stored animations using method chaining.
        public func animate() {
            switch self.animationType {
            case let .regular(duration, delay, options):
                UIView.animate(withDuration: duration,
                               delay: delay,
                               options: options,
                               animations: self.animations,
                               completion: self.completion)

            case let .spring(duration, delay, dampingRatio, velocity, options):
                UIView.animate(withDuration: duration,
                               delay: delay,
                               usingSpringWithDamping: dampingRatio,
                               initialSpringVelocity: velocity,
                               options: options,
                               animations: self.animations,
                               completion: self.completion)
            }
        }
    }

}
