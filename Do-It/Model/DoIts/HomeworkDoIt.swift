//
//  HomeworkDoIt.swift
//  Do-It
//
//  Created by Aaron on 1/16/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

struct HomeworkDoIt: DoIt {
    var id: DoItId
    var course: Course
    var dueDate: Date
    var description: String
    var name: String
    var priority: DoItPriority
}
