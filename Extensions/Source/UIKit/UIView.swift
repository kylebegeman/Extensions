//
//  UIView.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/22/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension UIView {

    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }

    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }

    /// Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    /// Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    /// Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    /// Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Height of view.
    var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }

    /// Width of view.
    var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }

    /// x origin of view.
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }

    /// y origin of view.
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }

    /// Getter and setter for the x coordinate of leftmost edge of the view.
    var left: CGFloat {
        get { return self.x }
        set(value) { self.x = value }
    }

    /// Getter and setter for the x coordinate of the rightmost edge of the view.
    var right: CGFloat {
        get { return self.x + self.width }
        set(value) { self.x = value - self.width }
    }

    /// Getter and setter for the y coordinate for the topmost edge of the view.
    var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

    /// Getter and setter for the y coordinate of the bottom most edge of the view.
    var bottom: CGFloat {
        get { return self.y + self.height }
        set(value) { self.y = value - self.height }
    }

    /// Getter and setter the frame's origin point of the view.
    var origin: CGPoint {
        get { return self.frame.origin }
        set(value) { self.frame = CGRect(origin: value, size: self.frame.size) }
    }

    /// Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

}

// MARK: - Methods

public extension UIView {
    /// Represents the sides of a view.
    enum ViewSide {
        case top
        case right
        case bottom
        case left
    }

    /// Load view from nib.
    ///
    /// - Returns: optional UIView (if applicable).
    static func instantiateFromNib() -> Self? {
        func instanceFromNib<T: UIView>() -> T? {
            return nib.instantiate() as? T
        }
        return instanceFromNib()
    }

    /// Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    /// Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({self.addSubview($0)})
    }

    /// Remove all subviews in view.
    func removeSubviews() {
        subviews.forEach({$0.removeFromSuperview()})
    }

    /// SwifterSwift: Remove all gesture recognizers from view.
    func removeGestureRecognizers() {
        gestureRecognizers?.forEach(removeGestureRecognizer)
    }

    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    /// Set all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - radius: radius for selected corners.
    func roundAllCorners(radius: CGFloat) {
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radius)
    }

    /// Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = true
    }

    /// Add a border to all sides.
    ///
    /// - Parameters:
    ///   - thickness: thickness of the border layer.
    ///   - color: background color of the border layer.
    func addBorder(thickness: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }


    /// Add a border to a single size of a UIView.
    ///
    /// - Parameters:
    ///   - side: the side of the UIView to add a border on.
    ///   - thickness: thickness of the border layer.
    ///   - color: background color of the border layer.
    ///   - leftOffset: offset from the left.
    ///   - rightOffset: offset from the right.
    ///   - topOffset: offset from the type.
    ///   - bottomOffset: offset from the bottom.
    /// - Returns: CALayer object representing the new border.
    func addBorder(side: ViewSide,
                             thickness: CGFloat,
                             color: UIColor,
                             leftOffset: CGFloat = 0,
                             rightOffset: CGFloat = 0,
                             topOffset: CGFloat = 0,
                             bottomOffset: CGFloat = 0) -> CALayer {

        switch side {
        case .top:
            // Bottom Offset Has No Effect
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: 0 + topOffset,
                                                    width: self.frame.size.width - leftOffset - rightOffset,
                                                    height: thickness), color: color)
        case .right:
            // Left Has No Effect
            // Subtract bottomOffset from the height to get our end.
            return _getOneSidedBorder(frame: CGRect(x: self.frame.size.width - thickness - rightOffset,
                                                    y: 0 + topOffset,
                                                    width: thickness,
                                                    height: self.frame.size.height), color: color)
        case .bottom:
            // Top has No Effect
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: self.frame.size.height - thickness - bottomOffset,
                                                    width: self.frame.size.width - leftOffset - rightOffset,
                                                    height: thickness), color: color)
        case .left:
            // Right Has No Effect
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: 0 + topOffset,
                                                    width: thickness,
                                                    height: self.frame.size.height - topOffset - bottomOffset), color: color)
        }
    }

    /// Returns a CALayer object to represent the border view.
    ///
    /// - Parameters:
    ///   - frame: the desited frame of the border.
    ///   - color: the desired color of the border.
    /// - Returns: CALayer object representing the border for the view.
    private func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border: CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }

    /// Add a border and color for debug viewing
    ///
    /// - Parameters:
    ///   - borderColor: color of the border (default .red).
    ///   - borderWidth: width of the border (default 1.0).
    func setDebugMode(borderColor: UIColor = .red, borderWidth: CGFloat = 1.0) {
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }

    /// An additional way to convert a UIView into and image object.
    ///
    /// - Returns: UIImage representation of the UIView.
    func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

}
