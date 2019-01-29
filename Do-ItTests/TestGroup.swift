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
    
    func printDates(arr: [(key: Date, value: [DoIt])]) {
        for (date, doit) in arr {
            print("Key: " + date.description)
            for val in doit {
                print("     Value " + val.course.name)
            }
        }
    }
    
    func printCourses(arr: [(key: String, value: [DoIt])]) {
        for (course, doit) in arr {
            print("Key: " + course)
            for val in doit {
                print("     Value " + val.course.name)
            }
        }
    }
    
    func printPriorities(arr: [(key: DoItPriority, value: [DoIt])]) {
        for (priority, doit) in arr {
            print("Key: " + String(priority.rawValue))
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
        
        let first = DoIt(id: DoItId(), course: Course(name: "CSC309"), dueDate: firstDate!, description: "Finish hw", name: "test", priority: DoItPriority.low, kind: .homework)
        let second = DoIt(id: DoItId(), course: Course(name: "ENGR234"), dueDate: secondDate!, description: "finish hw", name: "test", priority: DoItPriority.high, kind: .test)
        let third = DoIt(id: DoItId(), course: Course(name: "BUS313"), dueDate: thirdDate!, description: "finish hw", name: "test", priority: DoItPriority.default, kind: .test)
        let fourth = DoIt(id: DoItId(), course: Course(name: "CSC349"), dueDate: fourthDate!, description: "finish hw", name: "test", priority: DoItPriority.default, kind: .reading)
        let fifth = DoIt(id: DoItId(), course: Course(name: "BUS313"), dueDate: fifthDate!, description: "finish hw", name: "test", priority: DoItPriority.default, kind: .test)
        let sixth = DoIt(id: DoItId(), course: Course(name: "CSC349"), dueDate: sixthDate!, description: "finish hw", name: "test", priority: DoItPriority.default, kind: .homework)
        let lst = [first, second, third, fourth, fifth, sixth]
        let groupAlg = DoItGroup()
        
        let groupedByDate = groupAlg.groupByDate(ungroupedList: lst)
        print("Date Dictionary")
        printDates(arr: groupedByDate)
        XCTAssertEqual(groupedByDate[0].key, fourthDate)
        XCTAssertEqual(groupedByDate[1].key, sixthDate)
        XCTAssertEqual(groupedByDate[2].key, firstDate)
        XCTAssertEqual(groupedByDate[3].key, thirdDate)
        
        let groupedByCourse = groupAlg.groupByCourse(ungroupedList: lst)
        print("Course Dictionary: ")
        printCourses(arr: groupedByCourse)
        XCTAssertEqual(groupedByCourse[0].key, "BUS313")
        XCTAssertEqual(groupedByCourse[1].key, "CSC309")
        XCTAssertEqual(groupedByCourse[2].key, "CSC349")
        XCTAssertEqual(groupedByCourse[3].key, "ENGR234")
        
    
        let groupedByPriority = groupAlg.groupByPriority(ungroupedList: lst)
        print("Priority Dictionary: ")
        printPriorities(arr: groupedByPriority)
        XCTAssertEqual(groupedByPriority[0].key.rawValue, 3)
        XCTAssertEqual(groupedByPriority[1].key.rawValue, 2)
        XCTAssertEqual(groupedByPriority[2].key.rawValue, 1)
    }

}
