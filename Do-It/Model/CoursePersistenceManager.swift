//
//  CoursePersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation


final class CoursePersistenceManager {
    var courses: [Course] {
        didSet {
            saveCoursesToDisk()
        }
    }

    init() {
        courses = CoursePersistenceManager.loadCoursesFromDisk()
    }

    func save(_ course: Course) {

    }

    private static func loadCoursesFromDisk() -> [Course] {
        fatalError("not implemented")
    }

    private func saveCoursesToDisk() {

    }
}
