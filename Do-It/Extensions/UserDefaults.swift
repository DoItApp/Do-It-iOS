//
//  UserDefaults.swift
//  Do-It
//
//  Created by user146350 on 3/12/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation
import Do_ItCore

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
            let group = UserDefaults.standard.integer(forKey: Key.groupSetting)
            let sort = UserDefaults.standard.integer(forKey: Key.sortSetting)
            guard let courses = UserDefaults.standard.array(forKey: Key.courseOptions) as? [Course] else {return nil}
            guard let dates = UserDefaults.standard.array(forKey: Key.dateOptions) as? [Date] else {return nil}
            guard let priorities = UserDefaults.standard.array(forKey: Key.priorityOptions) as?
                [DoItPriority] else {return nil}
            guard let filters = UserDefaults.standard.array(forKey: Key.filterSetting)
                                                            as? [FilterSetting] else {return nil}
            for setting in filters {
                switch setting {
                case .course:
                    filterSettings.append(CourseFilter(courses[courseIndex]))
                    courseIndex += 1
                case .dueDate:
                    filterSettings.append(DueDateFilter(firstDay: dates[dateIndex], lastDay: dates[dateIndex + 1]))
                    dateIndex += 2
                case .priority:
                    filterSettings.append(PriorityFilter(input: priorities[priorityIndex]))
                    priorityIndex += 1
                }
            }
            if let group = GroupingSetting(rawValue: group) {
                return DoItOrganizationSettings(groupingSetting: group,
                                                sortSetting: SortSetting(rawValue: sort),
                                                filterSetting: filterSettings,
                                                filters: filters)
            }
            return nil
        }

        set {
            if let settings = organizationSettings {
                UserDefaults.standard.set(settings.groupingSetting.rawValue, forKey: Key.groupSetting)
                if let sort = settings.sortSetting {
                    UserDefaults.standard.set(sort, forKey: Key.sortSetting)
                } else {
                    UserDefaults.standard.set(-1, forKey: Key.sortSetting)
                }
                var courses: [Course] = []
                var dueDates: [Date] = []
                var priorities: [DoItPriority] = []
                for setting in settings.filterSetting {
                    switch setting {
                    case is CourseFilter:
                        if let filter = setting as? CourseFilter {
                            courses.append(filter.filterCourse)
                        }
                    case is DueDateFilter:
                        if let filter = setting as? DueDateFilter {
                            dueDates.append(filter.firstDate)
                            dueDates.append(filter.lastDate)
                        }
                    case is PriorityFilter:
                        if let filter = setting as? PriorityFilter {
                            priorities.append(filter.filterPriority)
                        }
                    default:
                        return
                    }
                }
                UserDefaults.standard.set(courses, forKey: Key.courseOptions)
                UserDefaults.standard.set(dueDates, forKey: Key.dateOptions)
                UserDefaults.standard.set(priorities, forKey: Key.priorityOptions)
                UserDefaults.standard.set(settings.filters, forKey: Key.filterSetting)
            }
        }
    }
}
