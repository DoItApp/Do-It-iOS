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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        courses = [Course(name: "CSC309"), Course(name: "ENGR234"),
                   Course(name: "BUS313"), Course(name: "CSC349")]

        let first = DoIt(identifier: DoItId(), course: courses[0],
                         dueDate: Date(timeIntervalSinceReferenceDate: 1000.0),
                         description: "Finish hw", name: "test", priority: .low, kind: .homework)
        let second = DoIt(identifier: DoItId(), course: courses[1],
                          dueDate: Date(timeIntervalSinceReferenceDate: 1000.0),
                          description: "finish hw", name: "test", priority: .high, kind: .test)
        let third = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "test", priority: .default, kind: .reading)
        let fourth = DoIt(identifier: DoItId(), course: courses[3],
                          dueDate: Date(timeIntervalSinceReferenceDate: 2000.0),
                          description: "finish hw", name: "test", priority: .default, kind: .homework)
        let fifth = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "test", priority: .low, kind: .reading)
        let sixth = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "test", priority: .low, kind: .reading)
        let seventh = DoIt(identifier: DoItId(), course: courses[2],
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "test", priority: .default, kind: .reading)
        doIts = [first, second, third, fourth, fifth, sixth, seventh]
    }

    func testOrganization1() {
        let organizationSettings = DoItOrganizationSettings(includedCourses: courses,
                                                            groupingSetting: GroupingSetting.dueDate,
                                                            sortSetting: SortSetting.priority)
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let organizedArray = organizationManager.organize(doIts)
        print(organizedArray)

    }
}
