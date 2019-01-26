//
//  TestSort.swift
//  Do-ItTests
//
//  Created by Cesar F. Chacon on 1/22/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_It


class TestSort: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let first = HomeworkDoIt(id: DoItId(), course: Course(name: "CSC309"), dueDate: Date(timeIntervalSinceReferenceDate: 1000.0), description: "Finish hw", name: "test", priority: DoItPriority.low)
        let second = HomeworkDoIt(id: DoItId(), course: Course(name: "ENGR234"), dueDate: Date(timeIntervalSinceReferenceDate: 1500.0), description: "finish hw", name: "test", priority: DoItPriority.high)
        let third = HomeworkDoIt(id: DoItId(), course: Course(name: "BUS313"), dueDate: Date(timeIntervalSinceReferenceDate: 100.0), description: "finish hw", name: "test", priority: DoItPriority.default)
        let fourth = HomeworkDoIt(id: DoItId(), course: Course(name: "CSC349"), dueDate: Date(timeIntervalSinceReferenceDate: 2000.0), description: "finish hw", name: "test", priority: DoItPriority.default)
        var lst = [first, second, third, fourth]
        let sortAlg = DoItSort()
        let sortedByCourse = sortAlg.sortBy(setting: .course, unsortedList: lst)
        XCTAssertEqual(sortedByCourse[0].course.name, "BUS313")
        XCTAssertEqual(sortedByCourse[1].course.name, "CSC309")
        XCTAssertEqual(sortedByCourse[2].course.name, "CSC349")
        XCTAssertEqual(sortedByCourse[3].course.name, "ENGR234")
        let sortedByPriority = sortAlg.sortBy(setting: .priority, unsortedList: lst)
        XCTAssertEqual(sortedByPriority[0].priority, DoItPriority.high)
        XCTAssertEqual(sortedByPriority[1].priority, DoItPriority.default)
        XCTAssertEqual(sortedByPriority[2].priority, DoItPriority.default)
        XCTAssertEqual(sortedByPriority[3].priority, DoItPriority.low)
        let sortedByDueDate = sortAlg.sortBy(setting: .dueDate, unsortedList: lst)
        XCTAssertEqual(sortedByDueDate[0].dueDate, Date(timeIntervalSinceReferenceDate: 100.0))
        XCTAssertEqual(sortedByDueDate[1].dueDate, Date(timeIntervalSinceReferenceDate: 1000.0))
        XCTAssertEqual(sortedByDueDate[2].dueDate, Date(timeIntervalSinceReferenceDate: 1500.0))
        XCTAssertEqual(sortedByDueDate[3].dueDate, Date(timeIntervalSinceReferenceDate: 2000.0))
    }

}
