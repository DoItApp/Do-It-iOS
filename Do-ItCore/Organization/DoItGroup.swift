//
//  DoItGroup.swift
//  Do-It
//
//  Created by Cesar F. Chacon on 1/22/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//
//

import Foundation

struct DoItGroup {
    func groupByCourse(ungroupedList: [DoIt]) -> [(key: String, value: [DoIt])] {
        return Dictionary(grouping: ungroupedList, by: { $0.course.name }).sorted(by: { lhs, rhs in
            return lhs.key < rhs.key
        })
    }

    func groupByDate(ungroupedList: [DoIt]) -> [(key: Date, value: [DoIt])] {
        let calendar = Calendar.current
        return Dictionary(grouping: ungroupedList, by: { calendar.startOfDay(for: $0.dueDate) })
            .sorted(by: { lhs, rhs in
                return lhs.key < rhs.key
        })
    }

    func groupByPriority(ungroupedList: [DoIt]) -> [(key: DoItPriority, value: [DoIt])] {
        return Dictionary(grouping: ungroupedList, by: { $0.priority }).sorted(by: { lhs, rhs in
            return lhs.key.rawValue > rhs.key.rawValue
        })
    }
}
