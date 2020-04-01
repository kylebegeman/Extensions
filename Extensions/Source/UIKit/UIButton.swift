//
//  UIButton.swift
//  Hubble
//
//  Created by Kyle Begeman on 1/23/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

// MARK: - Properties

public extension UIButton {

    /// Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var imageForDisabled: UIImage? {
        get { return image(for: .disabled) }
        set { setImage(newValue, for: .disabled) }
    }

    /// Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var imageForHighlighted: UIImage? {
        get { return image(for: .highlighted) }
        set { setImage(newValue, for: .highlighted) }
    }

    /// Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable var imageForNormal: UIImage? {
        get { return image(for: .normal) }
        set { setImage(newValue, for: .normal) }
    }

    /// Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable var imageForSelected: UIImage? {
        get { return image(for: .selected) }
        set { setImage(newValue, for: .selected) }
    }

    /// Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForDisabled: UIColor? {
        get { return titleColor(for: .disabled) }
        set { setTitleColor(newValue, for: .disabled) }
    }

    /// Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForHighlighted: UIColor? {
        get { return titleColor(for: .highlighted) }
        set { setTitleColor(newValue, for: .highlighted) }
    }

    /// Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForNormal: UIColor? {
        get { return titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }

    /// Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable var titleColorForSelected: UIColor? {
        get { return titleColor(for: .selected) }
        set { setTitleColor(newValue, for: .selected) }
    }

    /// Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable var titleForDisabled: String? {
        get { return title(for: .disabled) }
        set { setTitle(newValue, for: .disabled) }
    }

    /// Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable var titleForHighlighted: String? {
        get { return title(for: .highlighted) }
        set { setTitle(newValue, for: .highlighted) }
    }

    /// Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable var titleForNormal: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }

    /// Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable var titleForSelected: String? {
        get { return title(for: .selected) }
        set { setTitle(newValue, for: .selected) }
    }

}

// MARK: - Methods
public extension UIButton {

    // Reference for looping all states
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    /// Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { self.setImage(image, for: $0) }
    }

    /// Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { self.setTitleColor(color, for: $0) }
    }

    /// Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { self.setTitle(title, for: $0) }
    }

}
