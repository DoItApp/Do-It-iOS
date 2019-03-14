//
//  SharingIntegrationTests.swift
//  Do-ItTests
//
//  Created by Michael Pangburn on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import XCTest
@testable import Do_It
import Do_ItCore

class SharingIntegrationTests: XCTestCase {
    let controller = DoItTableViewController(nibName: nil, bundle: nil)
    let sharingManager = DoItSharingManager.shared
    let persistenceManager = DoItPersistenceManager.shared

    var incomingDoIts: [DoIt] = []

    override func setUp() {
        sharingManager.addObserver(controller)
        persistenceManager.doIts.removeAll()

        incomingDoIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 309"),
                          dueDate: Calendar.current.date(byAdding: .minute, value: 10, to: Date())!,
                          description: "description here",
                          name: "Assignment 1",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
        incomingDoIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 3000"),
                          dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                          description: "description here",
                          name: "Assignment 2",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        incomingDoIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 42"),
                          dueDate: Calendar.current.date(byAdding: .hour, value: 20, to: Date())!,
                          description: "description here",
                          name: "Assignment 3",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
    }

    func testSharingReception() {
        sharingManager.receiveDoIts(incomingDoIts)
        XCTAssertEqual(Set(controller.allDoIts), Set(incomingDoIts))
        XCTAssertEqual(Set(persistenceManager.doIts), Set(incomingDoIts))
    }
}
