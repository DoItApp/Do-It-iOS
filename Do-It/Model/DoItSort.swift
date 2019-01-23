//
//  DoItSort.swift
//  Do-It
//
//  Created by Cesar F. Chacon on 1/17/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

struct DoItSort {
    
    func sortBy(setting: SortSetting, unsortedList: [DoIt]) -> [DoIt] {
        return unsortedList.sorted(by: {lhs, rhs -> Bool in
            switch setting {
            case .course:
                return lhs.course.name < rhs.course.name
            case .dueDate:
                return lhs.dueDate < rhs.dueDate
            case .priority:
                return lhs.priority < rhs.priority
            }
        })
    }
}
