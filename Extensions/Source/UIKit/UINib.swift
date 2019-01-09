//
//  UINib.swift
//  Hubble
//
//  Created by Kyle Begeman on 3/5/18.
//  Copyright © 2018 Kyle Begeman. All rights reserved.
//

import UIKit

extension UINib {
    /// Convenience wrapper around UINib instantiate method.
    ///
    /// - Returns: nib if applicable
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
