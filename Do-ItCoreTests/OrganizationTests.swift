//
//  OrganizationTest.swift
//  Do-ItCoreTests
//
//  Created by user146350 on 2/21/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_ItCore

class OrganizationTests: XCTestCase {

    var doIts: [DoIt] = []
    var courses: [Course] = []
    var testArray1: [(String, [DoIt])] = []
    var testArray2: [(String, [DoIt])] = []
    var testArray3: [(String, [DoIt])] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        courses = [Course(name: "CSC309"), Course(name: "ENGR234"),
                   Course(name: "BUS313"), Course(name: "CSC349")]

        let first = DoIt(identifier: DoItId(), course: courses[0],
                         dueDate: Date(timeIntervalSinceReferenceDate: 1000.0),
                         description: "Finish hw", name: "1", priority: .low, kind: .homework)
        let second = DoIt(identifier: DoItId(), course: courses[2],
                          dueDate: Date(timeIntervalSinceReferenceDate: 1000000.0),
                          description: "finish hw", name: "2", priority: .high, kind: .test)
        let third = DoIt(identifier: DoItId(), course: courses[1],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "3", priority: .default, kind: .reading)
        let fourth = DoIt(identifier: DoItId(), course: courses[3],
                          dueDate: Date(timeIntervalSinceReferenceDate: 2000.0),
                          description: "finish hw", name: "4", priority: .default, kind: .homework)
        let fifth = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "5", priority: .high, kind: .reading)
        let sixth = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "6", priority: .low, kind: .reading)
        let seventh = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "7", priority: .default, kind: .reading)
        doIts = [first, second, third, fourth, fifth, sixth, seventh]
        testArray1 = [("Dec 31, 2000", [fifth]), ("Jan 12, 2001", [second])]
        testArray2 = [("High", [fifth, second]), ("Medium", [seventh]), ("Low", [sixth])]
        testArray3 = [("BUS313", [second, fifth, seventh, sixth] ), ("CSC309", [first]),
                      ("CSC349", [fourth]), ("ENGR234", [third])]
    }

    func testOrganization1() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let priorityFilter = PriorityFilter(input: .high)
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.dueDate,
                                                            sortSetting: SortSetting.priority,
                                                            filterSetting: [courseFilter, priorityFilter])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let organizedArray = organizationManager.organize(doIts)
        for index in 0...organizedArray.count - 1 {
            XCTAssertEqual(organizedArray[index].0, testArray1[index].0)
            for doit in 0...organizedArray[index].1.count - 1 {
                XCTAssertEqual(organizedArray[index].1[doit], testArray1[index].1[doit])
            }
        }
    }

    func testOrganization2() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.priority,
                                                            sortSetting: SortSetting.dueDate,
                                                            filterSetting: [courseFilter])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let organizedArray = organizationManager.organize(doIts)
        for index in 0...organizedArray.count - 1 {
            XCTAssertEqual(organizedArray[index].0, testArray2[index].0)
            for doit in 0...organizedArray[index].1.count - 1 {
                XCTAssertEqual(organizedArray[index].1[doit], testArray2[index].1[doit])
            }
        }
    }

    func testOrganization3() {
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.course,
                                                            sortSetting: SortSetting.priority,
                                                            filterSetting: [])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let organizedArray = organizationManager.organize(doIts)
        for index in 0...organizedArray.count - 1 {
            XCTAssertEqual(organizedArray[index].0, testArray3[index].0)
            for doit in 0...organizedArray[index].1.count - 1 {
                XCTAssertEqual(organizedArray[index].1[doit], testArray3[index].1[doit])
            }
        }
    }
}
