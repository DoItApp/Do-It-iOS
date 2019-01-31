//
//  Course.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

struct Course: Codable, Equatable {
    var name: String

    static func == (lhs: Course, rhs: Course) -> Bool {
        return lhs.name == rhs.name
    }
}
