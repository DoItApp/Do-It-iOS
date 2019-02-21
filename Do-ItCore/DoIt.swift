//
//  DoIt.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public struct DoIt: Codable, Equatable {
    public var identifier: DoItId
    public var course: Course
    public var dueDate: Date
    public var description: String
    public var name: String
    public var priority: DoItPriority
    public var kind: DoItKind

    public init(
        identifier: DoItId = DoItId(),
        course: Course,
        dueDate: Date,
        description: String,
        name: String,
        priority: DoItPriority,
        kind: DoItKind
    ) {
        self.identifier = identifier
        self.course = course
        self.dueDate = dueDate
        self.description = description
        self.name = name
        self.priority = priority
        self.kind = kind
    }
}
