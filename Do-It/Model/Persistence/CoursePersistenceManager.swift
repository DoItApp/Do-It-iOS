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
        docsURL = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        courseURL = docsURL.appendingPathComponent("Courses.json")
        courses = CoursePersistenceManager.loadCoursesFromDisk()
    }
    
    private static func loadCoursesFromDisk() -> [Course] {
        // Read data from .json file and transform data into an array
        do {
            let docsURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let courseURL = docsURL.appendingPathComponent("Courses.json")
            let data = try Data(contentsOf: courseURL, options: [])
            let courseArray =  try JSONSerialization.jsonObject(with: data, options: []) as! [Course]
            return courseArray
        } catch {
            print("Failed to read JSON data")
            return []
        }
    }
    
    private func saveCoursesToDisk() {
        do {
            let data = try JSONSerialization.data(withJSONObject: courses, options: [])
            try data.write(to: courseURL, options: [])
        } catch {
            print("Failed to write JSON data")
        }
    }
}

