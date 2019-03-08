//
//  CoursePersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public final class CoursePersistenceManager {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let fileManager = FileManager.default
    let docsURL: URL
    let courseURL: URL

    public static let shared = CoursePersistenceManager()

    public var courses: [Course] {
        didSet {
            saveCoursesToDisk()
        }
    }

    private init() {
        do {
            docsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                          appropriateFor: nil, create: true)
        } catch {
            fatalError("The app docs directory wil always exist")
        }
        courseURL = docsURL.appendingPathComponent("Courses.json")
        courses = []
        loadCoursesFromDisk()
    }

    private func loadCoursesFromDisk() {
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: courseURL, options: [])
            courses =  try decoder.decode([Course].self, from: data)
        } catch {
            print("Failed to read JSON data")
        }
    }

    public func testLoad() -> [Course] {
        loadCoursesFromDisk()
        return courses
    }

    private func saveCoursesToDisk() {
        do {
            let data = try encoder.encode(courses)
            try data.write(to: courseURL, options: [])
        } catch {
            print("Failed to write JSON data")
        }
    }

    public func save(_ course: Course) {
        courses.append(course)
    }
}
