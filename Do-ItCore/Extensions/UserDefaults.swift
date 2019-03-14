//
//  UserDefaults.swift
//  Do-It
//
//  Created by user146350 on 3/12/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

extension UserDefaults {
    private enum Key {
        static let groupSetting = "groupSetting"
        static let sortSetting = "sortSetting"
        static let filterSetting = "filterSetting"
        static let courseOptions = "courseOptions"
        static let dateOptions = "dateOptions"
        static let priorityOptions = "priorityOptions"
    }

    var organizationSettings: DoItOrganizationSettings? {
        get {
            var courseIndex = 0
            var dateIndex = 0
            var priorityIndex = 0
            var filterSettings: [FilterSpecification] = []
            let group = integer(forKey: Key.groupSetting)
            let sort = integer(forKey: Key.sortSetting)
            guard let courses = array(forKey: Key.courseOptions) as? [String] else {return nil}
            guard let dates = array(forKey: Key.dateOptions) as? [Date] else {return nil}
            guard let priorities = array(forKey: Key.priorityOptions) as?
                [Int] else {return nil}
            guard let filters = array(forKey: Key.filterSetting) as? [Int] else {return nil}
            for setting in filters {
                switch setting {
                case FilterSetting.course.rawValue:
                    filterSettings.append(CourseFilter(Course(name: courses[courseIndex])))
                    courseIndex += 1
                case FilterSetting.dueDate.rawValue:
                    filterSettings.append(DueDateFilter(firstDay: dates[dateIndex], lastDay: dates[dateIndex + 1]))
                    dateIndex += 2
                case FilterSetting.priority.rawValue:
                    if let priority = DoItPriority(rawValue: priorities[priorityIndex]) {
                        filterSettings.append(PriorityFilter(input: priority))
                        priorityIndex += 1
                    }
                default:
                    fatalError("Unknown sort setting")
                }
            }
            if let group = GroupingSetting(rawValue: group) {
                return DoItOrganizationSettings(groupingSetting: group,
                                                sortSetting: SortSetting(rawValue: sort),
                                                filterSetting: filterSettings)
            }
            return nil
        }

        set {
            if let settings = newValue {
                set(settings.groupingSetting.rawValue, forKey: Key.groupSetting)
                if let sort = settings.sortSetting?.rawValue {
                    set(sort, forKey: Key.sortSetting)
                } else {
                    set(-1, forKey: Key.sortSetting)
                }
                var courses: [String] = []
                var dueDates: [Date] = []
                var priorities: [Int] = []
                for setting in settings.filterSetting {
                    switch setting {
                    case let filter as CourseFilter:
                        courses.append(filter.filterCourse.name)
                    case let filter as DueDateFilter:
                        dueDates.append(filter.firstDate)
                        dueDates.append(filter.lastDate)
                    case let filter as PriorityFilter:
                        priorities.append(filter.filterPriority.rawValue)
                    default:
                        fatalError("unexpected filter type")
                    }
                }
                set(courses, forKey: Key.courseOptions)
                set(dueDates, forKey: Key.dateOptions)
                set(priorities, forKey: Key.priorityOptions)
                var filtersAsInt: [Int] = []
                for elm in settings.filters {
                    filtersAsInt.append(elm.rawValue)
                }
                set(filtersAsInt, forKey: Key.filterSetting)
            } else {
                removeObject(forKey: Key.groupSetting)
                removeObject(forKey: Key.sortSetting)
                removeObject(forKey: Key.filterSetting)
                removeObject(forKey: Key.courseOptions)
                removeObject(forKey: Key.dateOptions)
                removeObject(forKey: Key.priorityOptions)
            }
        }
    }
}
