//
//  PersistenceTest.swift
//  Do-ItTests
//
//  Created by user146350 on 1/29/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_ItCore

class DoItPersistenceTests: XCTestCase {
    func testDoItPersistence() {
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
        let persistence = DoItPersistenceManager.shared
        let lst = [first, second, third, fourth]
        persistence.doIts = lst
        let reload = persistence.testLoad()
        XCTAssertEqual(lst, reload)
    }
}
