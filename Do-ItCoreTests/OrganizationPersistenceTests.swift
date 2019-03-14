//
//  OrganizationPersistenceTests.swift
//  Do-ItCoreTests
//
//  Created by user146350 on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_ItCore

class OrganizationPersistenceTests: XCTestCase {

    var doIts: [DoIt] = []
    var courses: [Course] = []
    var testArray1: [(String, [DoIt])] = []
    var testArray2: [(String, [DoIt])] = []
    var testArray3: [(String, [DoIt])] = []
    let persistenceManager = DoItPersistenceManager.shared

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        courses = [Course(name: "CSC309"), Course(name: "ENGR234"),
                   Course(name: "BUS313"), Course(name: "CSC349")]

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

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
        testArray1 = [(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: 100.0)), [fifth]),
                      (dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: 1000000.0)), [second])]
        testArray2 = [("High", [fifth, second]), ("Medium", [seventh]), ("Low", [sixth])]
        testArray3 = [("BUS313", [second, fifth, seventh, sixth] ), ("CSC309", [first]),
                      ("CSC349", [fourth]), ("ENGR234", [third])]
    }

    func testOrganizationPersistence1() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let priorityFilter = PriorityFilter(input: .high)
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.dueDate,
                                                            sortSetting: SortSetting.priority,
                                                            filterSetting: [courseFilter, priorityFilter])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let originalOrganizedArray = organizationManager.organize(doIts)

        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        persistenceManager.doIts = doIts

        let loadedDoIts = persistenceManager.testLoad()
        if let loadedOrganizationSettings = UserDefaults.standard.organizationSettings {
            let loadedOrganizationManager = DoItOrganizationManager(organizationSettings: loadedOrganizationSettings)
            let loadedOrganizedArray = loadedOrganizationManager.organize(loadedDoIts)
            for index in originalOrganizedArray.indices {
                XCTAssertEqual(originalOrganizedArray[index].0, loadedOrganizedArray[index].0)
                for doit in originalOrganizedArray[index].1.indices {
                    XCTAssertEqual(originalOrganizedArray[index].1[doit], loadedOrganizedArray[index].1[doit])
                }
            }
        }
    }

    func testOrganizationPersistence2() {
        let courseFilter = CourseFilter(Course(name: courses[2].name))
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.priority,
                                                            sortSetting: SortSetting.dueDate,
                                                            filterSetting: [courseFilter])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let originalOrganizedArray = organizationManager.organize(doIts)

        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        persistenceManager.doIts = doIts

        let loadedDoIts = persistenceManager.testLoad()
        if let loadedOrganizationSettings = UserDefaults.standard.organizationSettings {
            let loadedOrganizationManager = DoItOrganizationManager(organizationSettings: loadedOrganizationSettings)
            let loadedOrganizedArray = loadedOrganizationManager.organize(loadedDoIts)
            for index in originalOrganizedArray.indices {
                XCTAssertEqual(originalOrganizedArray[index].0, loadedOrganizedArray[index].0)
                for doit in originalOrganizedArray[index].1.indices {
                    XCTAssertEqual(originalOrganizedArray[index].1[doit], loadedOrganizedArray[index].1[doit])
                }
            }
        }
    }

    func testOrganizationPersistence3() {
        let organizationSettings = DoItOrganizationSettings(groupingSetting: GroupingSetting.course,
                                                            sortSetting: SortSetting.priority,
                                                            filterSetting: [])
        let organizationManager = DoItOrganizationManager(organizationSettings: organizationSettings)
        let originalOrganizedArray = organizationManager.organize(doIts)

        UserDefaults.standard.organizationSettings = nil
        UserDefaults.standard.organizationSettings = organizationSettings
        persistenceManager.doIts = doIts

        let loadedDoIts = persistenceManager.testLoad()
        if let loadedOrganizationSettings = UserDefaults.standard.organizationSettings {
            let loadedOrganizationManager = DoItOrganizationManager(organizationSettings: loadedOrganizationSettings)
            let loadedOrganizedArray = loadedOrganizationManager.organize(loadedDoIts)
            for index in originalOrganizedArray.indices {
                XCTAssertEqual(originalOrganizedArray[index].0, loadedOrganizedArray[index].0)
                for doit in originalOrganizedArray[index].1.indices {
                    XCTAssertEqual(originalOrganizedArray[index].1[doit], loadedOrganizedArray[index].1[doit])
                }
            }
        }
    }
}
