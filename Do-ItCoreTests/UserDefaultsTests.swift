//
//  UserDefaultsTests.swift
//  Do-ItTests
//
//  Created by user146350 on 3/12/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_ItCore
class UserDefaultsTests: XCTestCase {

    var courses: [Course] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        courses = [Course(name: "CSC309"), Course(name: "ENGR234"),
                   Course(name: "BUS313"), Course(name: "CSC349")]
    }

    func testuserDefaults1() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let priorityFilter = PriorityFilter(input: .high)
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.dueDate,
                                                            sortSetting: SortSetting.priority,
                                                            filterSetting: [courseFilter, priorityFilter])
        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        if let readSettings = UserDefaults.standard.organizationSettings {
            XCTAssertEqual(organizationSettings.groupingSetting, readSettings.groupingSetting)
            XCTAssertEqual(organizationSettings.sortSetting, readSettings.sortSetting)
            XCTAssertEqual(organizationSettings.getFilters(), readSettings.getFilters())
            XCTAssertEqual(organizationSettings.filterSetting.count, readSettings.filterSetting.count)
            for index in organizationSettings.filterSetting.indices {
                switch organizationSettings.filterSetting[index] {
                case let filter1 as CourseFilter:
                    if let filter2 = readSettings.filterSetting[index] as? CourseFilter {
                    XCTAssertEqual(filter1.filterCourse, filter2.filterCourse)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as DueDateFilter:
                    if let filter2 = readSettings.filterSetting[index] as? DueDateFilter {
                        XCTAssertEqual(filter1.firstDate, filter2.firstDate)
                        XCTAssertEqual(filter1.lastDate, filter2.lastDate)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as PriorityFilter:
                    if let filter2 = readSettings.filterSetting[index] as? PriorityFilter {
                        XCTAssertEqual(filter1.filterPriority, filter2.filterPriority)
                    } else {
                        XCTFail("mismatch filter")
                    }
                default:
                    XCTFail("unknown filter type")
                }
            }
        } else {
            XCTFail("UserDefaults returned nil object")
        }
    }

    func testUserDefaults2() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.priority,
                                                            sortSetting: SortSetting.dueDate,
                                                            filterSetting: [courseFilter])
        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        if let readSettings = UserDefaults.standard.organizationSettings {
            XCTAssertEqual(organizationSettings.groupingSetting, readSettings.groupingSetting)
            XCTAssertEqual(organizationSettings.sortSetting, readSettings.sortSetting)
            XCTAssertEqual(organizationSettings.getFilters(), readSettings.getFilters())
            XCTAssertEqual(organizationSettings.filterSetting.count, readSettings.filterSetting.count)
            for index in organizationSettings.filterSetting.indices {
                switch organizationSettings.filterSetting[index] {
                case let filter1 as CourseFilter:
                    if let filter2 = readSettings.filterSetting[index] as? CourseFilter {
                        XCTAssertEqual(filter1.filterCourse, filter2.filterCourse)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as DueDateFilter:
                    if let filter2 = readSettings.filterSetting[index] as? DueDateFilter {
                        XCTAssertEqual(filter1.firstDate, filter2.firstDate)
                        XCTAssertEqual(filter1.lastDate, filter2.lastDate)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as PriorityFilter:
                    if let filter2 = readSettings.filterSetting[index] as? PriorityFilter {
                        XCTAssertEqual(filter1.filterPriority, filter2.filterPriority)
                    } else {
                        XCTFail("mismatch filter")
                    }
                default:
                    XCTFail("unknown filter type")
                }
            }
        } else {
            XCTFail("UserDefaults returned nil object")
        }
    }

    func testUserDefaults3() {
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.course,
                                                            sortSetting: nil,
                                                            filterSetting: [])
        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        if let readSettings = UserDefaults.standard.organizationSettings {
            XCTAssertEqual(organizationSettings.groupingSetting, readSettings.groupingSetting)
            XCTAssertEqual(organizationSettings.sortSetting, readSettings.sortSetting)
            XCTAssertEqual(organizationSettings.getFilters(), readSettings.getFilters())
            XCTAssertEqual(organizationSettings.filterSetting.count, readSettings.filterSetting.count)
            for index in organizationSettings.filterSetting.indices {
                switch organizationSettings.filterSetting[index] {
                case let filter1 as CourseFilter:
                    if let filter2 = readSettings.filterSetting[index] as? CourseFilter {
                        XCTAssertEqual(filter1.filterCourse, filter2.filterCourse)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as DueDateFilter:
                    if let filter2 = readSettings.filterSetting[index] as? DueDateFilter {
                        XCTAssertEqual(filter1.firstDate, filter2.firstDate)
                        XCTAssertEqual(filter1.lastDate, filter2.lastDate)
                    } else {
                        XCTFail("mismatch filter")
                    }
                case let filter1 as PriorityFilter:
                    if let filter2 = readSettings.filterSetting[index] as? PriorityFilter {
                        XCTAssertEqual(filter1.filterPriority, filter2.filterPriority)
                    } else {
                        XCTFail("mismatch filter")
                    }
                default:
                    XCTFail("unknown filter type")
                }
            }
        } else {
            XCTFail("UserDefaults returned nil object")
        }
    }
}
