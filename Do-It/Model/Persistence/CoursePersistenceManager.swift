//
//  CoursePersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

final class CoursePersistenceManager {
    var encoder = JSONEncoder()
    var decoder = JSONDecoder()
    var fileManager = FileManager.default
    var docsURL: URL
    var courseURL: URL
    var courses: [Course] {
        didSet {
            saveCoursesToDisk()
        }
    }

    init() {
        do {
            docsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                          appropriateFor: nil, create: true)
        } catch {
            fatalError("The app docs directory wil always exist")
        }
        courseURL = docsURL.appendingPathComponent("Courses.json")
        courses = CoursePersistenceManager.loadCoursesFromDisk()
    }

    private static func loadCoursesFromDisk() -> [Course] {
        // Read data from .json file and transform data into an array
        do {
            let docsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                      appropriateFor: nil, create: false)
            let courseURL = docsURL.appendingPathComponent("Courses.json")
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: courseURL, options: [])
            let courseArray =  try decoder.decode([Course].self, from: data)
            return courseArray
        } catch {
            print("Failed to read JSON data")
            return []
        }
    }

    public static func testLoad() -> [Course] {
        return loadCoursesFromDisk()
    }

    private func saveCoursesToDisk() {
        do {
            let data = try encoder.encode(courses)
            try data.write(to: courseURL, options: [])
        } catch {
            print("Failed to write JSON data")
        }
    }
}
