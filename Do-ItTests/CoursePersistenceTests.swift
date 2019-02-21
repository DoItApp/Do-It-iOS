//
//  CoursePersistenceTests.swift
//  Do-ItTests
//
//  Created by user146350 on 2/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//
import XCTest
@testable import Do_It

class CoursePersistenceTests: XCTestCase {

    override func setUp() {
        // put code here if needed
    }

    override func tearDown() {
        // put code here if needed
    }

    func testCoursePersistence() {
        let first = Course(name: "CSC305")
        let second = Course(name: "PHIL231")
        let third = Course(name: "MU301")
        let fourth = Course(name: "BUS313")
        let persistence = CoursePersistenceManager.shared
        let lst = [first, second, third, fourth]
        persistence.courses = lst
        let reload = persistence.testLoad()
        XCTAssertEqual(lst, reload)
    }
}
