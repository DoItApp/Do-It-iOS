//
//  DoItFilter.swift
//  Do-It
//
//  Created by Jett Moy on 1/17/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public protocol FilterSpecification {
    func applyFilter(_ doIts: [DoIt]) -> [DoIt]
}

public class DoItsFilter {
    public func filter(_ doIts: [DoIt], filterType: FilterSpecification) -> [DoIt] {
        return filterType.applyFilter(doIts)
    }
}

public struct CourseFilter: FilterSpecification {
    var filterCourse: Course

    public init(_ input: Course) {
        filterCourse = input
    }

    public func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in doIt.course == filterCourse})
    }
}

public struct DueDateFilter: FilterSpecification {
    var firstDate: Date
    var lastDate: Date

    public init(firstDay: Date, lastDay: Date) {
        firstDate = firstDay
        lastDate = lastDay
    }

    public func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in
            doIt.dueDate < lastDate && doIt.dueDate > firstDate
        })
    }
}

public struct PriorityFilter: FilterSpecification {
    var filterPriority: DoItPriority

    public init(input: DoItPriority) {
        filterPriority = input
    }

    public func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in doIt.priority == filterPriority})
    }
}
