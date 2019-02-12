//
//  DoItFilter.swift
//  Do-It
//
//  Created by Jett Moy on 1/17/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

protocol FilterSpecification {
    func applyFilter (_ doIts: [DoIt]) -> [DoIt]
}

class DoItsFilter {
    func filter(_ doIts: [DoIt], filterType: FilterSpecification) -> [DoIt] {
        return filterType.applyFilter(doIts)
    }
}

struct CourseFilter: FilterSpecification {
    var filterCourse: Course

    init (_ input: Course) {
        filterCourse = input
    }

    func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in doIt.course == filterCourse})
    }
}

struct DueDateFilter: FilterSpecification {
    var firstDate: Date
    var lastDate: Date

    init(firstDay: Date, lastDay: Date) {
        firstDate = firstDay
        lastDate = lastDay
    }

    func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in
            doIt.dueDate < lastDate && doIt.dueDate > firstDate
        })
    }
}

struct PriorityFilter: FilterSpecification {
    var filterPriority: DoItPriority

    init(input: DoItPriority) {
        filterPriority = input
    }

    func applyFilter(_ doIts: [DoIt]) -> [DoIt] {
        return doIts.filter({ (doIt) -> Bool in doIt.priority == filterPriority})
    }
}
