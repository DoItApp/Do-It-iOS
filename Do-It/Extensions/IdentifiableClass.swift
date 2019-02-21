//
//  IdentifiableClass.swift
//  Do-It
//
//  Created by Michael Pangburn on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

protocol IdentifiableClass: class {
    static var className: String { get }
}

extension IdentifiableClass {
    static var className: String {
        return String(describing: self)
    }
}
