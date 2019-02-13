//
//  TestFilter.swift
//  Do-ItTests
//
//  Created by Jett Moy on 2/7/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation
import XCTest
@testable import Do_It

class TesFilter: XCTestCase {
    var doIts: [DoIt] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let first = DoIt(identifier: DoItId(), course: Course(name: "CSC309"),
                         dueDate: Date(timeIntervalSinceReferenceDate: 1000.0),
                         description: "Finish hw", name: "test", priority: .low, kind: .homework)
        let second = DoIt(identifier: DoItId(), course: Course(name: "ENGR234"),
                          dueDate: Date(timeIntervalSinceReferenceDate: 1500.0),
                          description: "finish hw", name: "test", priority: .high, kind: .test)
        let third = DoIt(identifier: DoItId(), course: Course(name: "BUS313"),
                         dueDate: Date(timeIntervalSinceReferenceDate: 100.0),
                         description: "finish hw", name: "test", priority: .default, kind: .reading)
        let fourth = DoIt(identifier: DoItId(), course: Course(name: "CSC349"),
                          dueDate: Date(timeIntervalSinceReferenceDate: 2000.0),
                          description: "finish hw", name: "test", priority: .default, kind: .homework)
        doIts = [first, second, third, fourth]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFilter() {
        testCourseFilter()
        testPriorityFilter()
        testDueDateFilter()
    }

    func testCourseFilter() {
        testCourseFilterSingle()
        testCourseFilterTwo()
    }

    func testPriorityFilter() {
        testPriorityFilterSingle()
    }

    func testDueDateFilter() {
        testDueDateFilterSingle()
    }

    func testCourseFilterSingle() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let filterAlg = DoItsFilter()
        let courseFilter = CourseFilter(Course(name: "CSC349"))
        let byCourse = filterAlg.filter(doIts, filterType: courseFilter)
        XCTAssertEqual(byCourse[0].course.name, "CSC349", "DoIt course was not CSC349.")
    }

    func testCourseFilterTwo() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let filterAlg = DoItsFilter()
        let courseFilter1 = CourseFilter(Course(name: "BUS313"))
        let byCourse = filterAlg.filter(doIts, filterType: courseFilter1)
        XCTAssertEqual(byCourse[0].course.name, "BUS313", "DoIt course was not BUS313.")
    }

    func testPriorityFilterSingle() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let filterAlg = DoItsFilter()
        let priorityFilter = PriorityFilter(input: .high)
        let byPriority = filterAlg.filter(doIts, filterType: priorityFilter)
        XCTAssertEqual(byPriority[0].priority, .high, "DoIt priority was not high.")
    }

    func testDueDateFilterSingle() {
        let date1 = Date(timeIntervalSinceReferenceDate: 1600.0)
        let date2 = Date(timeIntervalSinceReferenceDate: 2100.0)
        let filterAlg = DoItsFilter()
        let dueDateFilter = DueDateFilter(firstDay: date1, lastDay: date2)
        let filteredByDueDate = filterAlg.filter(doIts, filterType: dueDateFilter)
        XCTAssertEqual(filteredByDueDate[0].dueDate,
            Date(timeIntervalSinceReferenceDate: 2000.0), "DoIt due date did not include 2000.0")
    }
}
