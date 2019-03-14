//
//  CoursePersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public final class CoursePersistenceManager: PersistenceManager {
    public let encoder: Encoder = JSONEncoder()
    public let decoder: Decoder = JSONDecoder()

    public let savedFileName = "Courses.json"

    public static let shared = CoursePersistenceManager()

    public var courses: [Course] = [] {
        didSet {
            saveToDisk()
        }
    }

    private init() {
        loadFromDisk()
    }

    /// Fulfills PersistenceManager protocol; equivalent to `courses` array.
    public var managedData: [Course] {
        get {
            return courses
        }
        set {
            courses = newValue
        }
    }

    @discardableResult
    public func deleteCourse(matching name: String) -> Course? {
        guard let index = courses.firstIndex(where: { $0.name == name }) else {
            return nil
        }
        return courses.remove(at: index)
    }
}
