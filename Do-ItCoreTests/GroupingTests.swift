//
//  GroupingTests.swift
//  Do-ItTests
//
//  Created by Cesar F. Chacon on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_ItCore

class GroupingTests: XCTestCase {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    lazy var firstDate = formatter.date(from: "2018/9/15")
    lazy var secondDate = formatter.date(from: "2018/9/15")
    lazy var thirdDate = formatter.date(from: "2018/10/08")
    lazy var fourthDate = formatter.date(from: "2017/5/22")
    lazy var fifthDate = formatter.date(from: "2017/7/07")
    lazy var sixthDate = formatter.date(from: "2017/7/07")

    lazy var doIts: [DoIt] = {
        let first = DoIt(identifier: DoItId(), course: Course(name: "CSC309"), dueDate: firstDate!,
                         description: "Finish hw", name: "test", priority: DoItPriority.low, kind: .homework)
        let second = DoIt(identifier: DoItId(), course: Course(name: "ENGR234"), dueDate: secondDate!,
                          description: "finish hw", name: "test", priority: DoItPriority.high, kind: .test)
        let third = DoIt(identifier: DoItId(), course: Course(name: "BUS313"), dueDate: thirdDate!,
                         description: "finish hw", name: "test", priority: DoItPriority.default, kind: .test)
        let fourth = DoIt(identifier: DoItId(), course: Course(name: "CSC349"), dueDate: fourthDate!,
                          description: "finish hw", name: "test", priority: DoItPriority.default, kind: .reading)
        let fifth = DoIt(identifier: DoItId(), course: Course(name: "BUS313"), dueDate: fifthDate!,
                         description: "finish hw", name: "test", priority: DoItPriority.default, kind: .test)
        let sixth = DoIt(identifier: DoItId(), course: Course(name: "CSC349"), dueDate: sixthDate!,
                         description: "finish hw", name: "test", priority: DoItPriority.default, kind: .homework)
        return [first, second, third, fourth, fifth, sixth]
    }()

    let groupAlg = DoItGroup()

    func testGroupByDate() {
        let groupedByDate = groupAlg.groupByDate(ungroupedList: doIts)
        XCTAssertEqual(groupedByDate[0].key, fourthDate)
        XCTAssertEqual(groupedByDate[1].key, sixthDate)
        XCTAssertEqual(groupedByDate[2].key, firstDate)
        XCTAssertEqual(groupedByDate[3].key, thirdDate)
    }

    func testGroupByCuorse() {
        let groupedByCourse = groupAlg.groupByCourse(ungroupedList: doIts)
        XCTAssertEqual(groupedByCourse[0].key, "BUS313")
        XCTAssertEqual(groupedByCourse[1].key, "CSC309")
        XCTAssertEqual(groupedByCourse[2].key, "CSC349")
        XCTAssertEqual(groupedByCourse[3].key, "ENGR234")
    }

    func testGroupByPriority() {
        let groupedByPriority = groupAlg.groupByPriority(ungroupedList: doIts)
        XCTAssertEqual(groupedByPriority[0].key.rawValue, 3)
        XCTAssertEqual(groupedByPriority[1].key.rawValue, 2)
        XCTAssertEqual(groupedByPriority[2].key.rawValue, 1)
    }
}
