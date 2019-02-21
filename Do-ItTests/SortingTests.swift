//
//  SortingTests.swift
//  Do-ItTests
//
//  Created by Cesar F. Chacon on 1/22/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_It

class SortingTests: XCTestCase {
    let doIts: DoIt = {
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
        return [first, second, third, fourth]
    }()

    let sortAlg = DoItSort()

    func testSortByCourse() {
        let sortedByCourse = sortAlg.sortBy(setting: .course, unsortedList: doIts)
        XCTAssertEqual(sortedByCourse[0].course.name, "BUS313")
        XCTAssertEqual(sortedByCourse[1].course.name, "CSC309")
        XCTAssertEqual(sortedByCourse[2].course.name, "CSC349")
        XCTAssertEqual(sortedByCourse[3].course.name, "ENGR234")
    }

    func testSortByPriority() {
        let sortedByPriority = sortAlg.sortBy(setting: .priority, unsortedList: doIts)
        XCTAssertEqual(sortedByPriority[0].priority, DoItPriority.high)
        XCTAssertEqual(sortedByPriority[1].priority, DoItPriority.default)
        XCTAssertEqual(sortedByPriority[2].priority, DoItPriority.default)
        XCTAssertEqual(sortedByPriority[3].priority, DoItPriority.low)
    }

    func testSortByDueDate() {
        let sortedByDueDate = sortAlg.sortBy(setting: .dueDate, unsortedList: doIts)
        XCTAssertEqual(sortedByDueDate[0].dueDate, Date(timeIntervalSinceReferenceDate: 100.0))
        XCTAssertEqual(sortedByDueDate[1].dueDate, Date(timeIntervalSinceReferenceDate: 1000.0))
        XCTAssertEqual(sortedByDueDate[2].dueDate, Date(timeIntervalSinceReferenceDate: 1500.0))
        XCTAssertEqual(sortedByDueDate[3].dueDate, Date(timeIntervalSinceReferenceDate: 2000.0))
    }
}
