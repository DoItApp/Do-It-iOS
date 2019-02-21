//
//  NibLoadable.swift
//  Do-It
//
//  Created by Michael Pangburn on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

protocol NibLoadable: IdentifiableClass {
    static func nib() -> UINib
}

extension NibLoadable {
    static func nib() -> UINib {
        return UINib(nibName: className, bundle: Bundle(for: self))
    }
}
