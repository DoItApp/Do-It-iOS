//
//  DoItPersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

final class DoItPersistenceManager {
    var encoder = JSONEncoder()
    var decoder = JSONDecoder()
    var fileManager = FileManager.default
    var docsURL: URL
    var doItsURL: URL
    var doIts: [DoIt] {
        didSet {
            saveDoItsToDisk()
        }
    }

    init() {
        do {
            docsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                          appropriateFor: nil, create: true)
        } catch {
            fatalError("The app docs directory wil always exist")
        }
        doItsURL = docsURL.appendingPathComponent("DoIts.json")
        print(doItsURL)
        doIts = DoItPersistenceManager.loadDoItsFromDisk()
    }

    private static func loadDoItsFromDisk() -> [DoIt] {
        // Read data from .json file and transform data into an array
        do {
            let docsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                      appropriateFor: nil, create: false)
            let doItsURL = docsURL.appendingPathComponent("DoIts.json")
            let data = try Data(contentsOf: doItsURL, options: [])
            let decoder = JSONDecoder()
            let doItsArray =  try decoder.decode([DoIt].self, from: data)
            return doItsArray
        } catch {
            print("Failed to read JSON data")
            return []
        }
    }

    public static func testLoad() -> [DoIt] {
        return loadDoItsFromDisk()
    }

    private func saveDoItsToDisk() {
        do {
            let data = try encoder.encode(doIts)
            try data.write(to: doItsURL, options: [])
        } catch {
            print("Failed to write JSON data")
        }
    }
}
