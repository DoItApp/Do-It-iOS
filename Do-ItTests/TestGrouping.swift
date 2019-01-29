//
//  TestGrouping.swift
//  Do-ItTests
//
//  Created by Cesar F. Chacon on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_It

class TestGrouping: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func printDictionary(dict: Dictionary<String, [DoIt]>) {
        for (string, doit) in dict {
            print("Key: " + string)
            for val in doit {
                print("     Value " + val.course.name)
            }
        }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let firstDate = formatter.date(from: "2018/9/15")
        let secondDate = formatter.date(from: "2018/9/15")
        let thirdDate = formatter.date(from: "2018/10/08")
        let fourthDate = formatter.date(from: "2017/5/22")
        let fifthDate = formatter.date(from: "2017/7/07")
        let sixthDate = formatter.date(from: "2017/7/07")
        
        let first = HomeworkDoIt(id: DoItId(), course: Course(name: "CSC309"), dueDate: firstDate!, description: "Finish hw", name: "test", priority: DoItPriority.low)
        let second = HomeworkDoIt(id: DoItId(), course: Course(name: "ENGR234"), dueDate: secondDate!, description: "finish hw", name: "test", priority: DoItPriority.high)
        let third = HomeworkDoIt(id: DoItId(), course: Course(name: "BUS313"), dueDate: thirdDate!, description: "finish hw", name: "test", priority: DoItPriority.default)
        let fourth = HomeworkDoIt(id: DoItId(), course: Course(name: "CSC349"), dueDate: fourthDate!, description: "finish hw", name: "test", priority: DoItPriority.default)
        let fifth = HomeworkDoIt(id: DoItId(), course: Course(name: "BUS313"), dueDate: fifthDate!, description: "finish hw", name: "test", priority: DoItPriority.default)
        let sixth = HomeworkDoIt(id: DoItId(), course: Course(name: "CSC349"), dueDate: sixthDate!, description: "finish hw", name: "test", priority: DoItPriority.default)
        let lst = [first, second, third, fourth, fifth, sixth]
        let groupAlg = DoItGroup()
        
        let groupedByDate = groupAlg.groupBy(setting: .dueDate, ungroupedList: lst)
        print("Date Dictionary")
        printDictionary(dict: groupedByDate)
        XCTAssertEqual(groupedByCourse["Sep 15, 2018"]![0].course.name, first.course.name)
        XCTAssertEqual(groupedByCourse["Jul 7, 2017"], [third, fifth])
        XCTAssertEqual(groupedByCourse["Oct 8, 2018"], [fourth, sixth])
        
        let groupedByCourse = groupAlg.groupBy(setting: .course, ungroupedList: lst)
        print("Course Dictionary: ")
        printDictionary(dict: groupedByCourse)
        XCTAssertEqual(groupedByCourse["CSC349"]![0].course.name, "CSC349")
        XCTAssertEqual(groupedByCourse["CSC349"]![1].course.name, "CSC349")
        XCTAssertEqual(groupedByCourse["ENGR234"]![0].course.name, "ENGR234")
        XCTAssertEqual(groupedByCourse["BUS313"]![0].course.name, "BUS313")
        XCTAssertEqual(groupedByCourse["BUS313"]![1].course.name, "BUS313")
        XCTAssertEqual(groupedByCourse["CSC309"]![0].course.name, "CSC309")
        
    
        let groupedByPriority = groupAlg.groupBy(setting: .priority, ungroupedList: lst)
        print("Priority Dictionary: ")
        printDictionary(dict: groupedByPriority)
        XCTAssertEqual(groupedByCourse["high"]![0].priority, second.priority)
        XCTAssertEqual(groupedByCourse["default"]![0].priority, third.priority)
        XCTAssertEqual(groupedByCourse["default"]![1].priority, fourth.priority)
        XCTAssertEqual(groupedByCourse["default"]![2].priority, fifth.priority)
        XCTAssertEqual(groupedByCourse["default"]![3].priority, sixth.priority)
        XCTAssertEqual(groupedByCourse["low"]![0].priority, first.priority)
        
        
    }

}
