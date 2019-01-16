//
//  ExampleTests.swift
//  Do-ItTests
//
//  Created by Michael Pangburn on 1/15/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest


// This is a dummy struct to demonstrate testing
struct Person {
    var firstName: String
    var lastName: String

    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

// To add a new test case class,
// go to File > New File and select Unit Test Case Class.

// To run your tess in Xcode, do one of the following:
// - Click the little button to the left of the line of code declaring the test case class.
//     - This option will run this class of tests exclusively.
// - Click Product > Test (or press CMD+U) to run all test case classes.
class ExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let person = Person(firstName: "Swifty", lastName: "P")
        XCTAssertEqual(person.firstName, "Swifty")
        XCTAssertEqual(person.lastName, "P")
        XCTAssertEqual(person.fullName, "Swifty P")

        // See the XCTest documentation for more useful assert methods
        // e.g. XCTAssertNil, XCTAssertFalse, etc.
    }
}
