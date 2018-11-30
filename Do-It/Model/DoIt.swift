//
//  DoIt.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation


struct DoIt {
    let id = DoItId()
    var course: Course
    var dueDate: Date
    var description: String
    var name: String
    var priority: DoItPriority
}
