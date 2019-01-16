//
//  ReadingDoIt.swift
//  Do-It
//
//  Created by Aaron on 1/16/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

struct ReadingDoIt : DoIt {
    var id: DoItId
    var course: Course
    var dueDate: Date
    var description: String
    var name: String
    var priority: DoItPriority
    
    let pageStart : Int
    let pageEnd : Int
    
    
    init(id: DoItId, course: Course, dueDate: Date, description: String,
         name: String, priority: DoItPriority, pageStart: Int, pageEnd: Int) {
        self.id = id
        self.course = course
        self.dueDate = dueDate
        self.description = description
        self.name = name
        self.priority = priority
        self.pageStart = pageStart
        self.pageEnd = pageEnd
    }
}
