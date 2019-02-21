//
//  DoItTableViewControllerTests.swift
//  Do-ItTests
//
//  Created by Aaron on 2/19/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
<<<<<<< HEAD
import Do_ItCore
=======
// @testable import DoItTableViewController
>>>>>>> doit-table-view-controller
@testable import Do_It

class DoItTableViewControllerTests: XCTestCase {

    var doIts = [DoIt]()
    let formatter = DateComponentsFormatter()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 309"),
                          dueDate: Calendar.current.date(byAdding: .minute, value: 10, to: Date())!,
                          description: "description here",
                          name: "Assignment 1",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 3000"),
                          dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                          description: "description here",
                          name: "Assignment 2",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 42"),
                          dueDate: Calendar.current.date(byAdding: .hour, value: 20, to: Date())!,
                          description: "description here",
                          name: "Assignment 3",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormattedDateMinute() {
        XCTAssertEqual(formattedDate(index: 0), "9 minutes")
    }

    func testFormattedDateHour() {
        XCTAssertEqual(formattedDate(index: 1), "29 days")
    }

    func testFormattedDateDay() {
        XCTAssertEqual(formattedDate(index: 2), "19 hours")
    }

    func formattedDate(index: Int) -> String? {
        let diffDateComponents = Calendar.current.dateComponents([.day, .hour, .minute],
                                                                 from: Date(),
                                                                 to: doIts[index].dueDate)

        formatter.unitsStyle = .full

        if diffDateComponents.day == 0 && diffDateComponents.hour == 0 {
            formatter.allowedUnits = [.minute]
        } else if diffDateComponents.day == 0 {
            formatter.allowedUnits = [.hour]
        } else {
            formatter.allowedUnits = [.day]
        }

        return formatter.string(from: diffDateComponents)
    }

}
