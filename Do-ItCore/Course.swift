//
//  Course.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public struct Course: Codable, Hashable {
    public var name: String

    public init(name: String) {
        self.name = name
    }
}
