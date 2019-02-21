//
//  DoItPersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

final class DoItPersistenceManager {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let fileManager = FileManager.default
    let docsURL: URL
    let doItsURL: URL
    static let shared = DoItPersistenceManager()
    var doIts: [DoIt] {
        didSet {
            saveDoItsToDisk()
        }
    }

    private init() {
        do {
            docsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                          appropriateFor: nil, create: true)
        } catch {
            fatalError("The app docs directory wil always exist")
        }
        doItsURL = docsURL.appendingPathComponent("DoIts.json")
        doIts = []
        loadDoItsFromDisk()
    }

    private func loadDoItsFromDisk() {
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: doItsURL, options: [])
            doIts =  try decoder.decode([DoIt].self, from: data)
        } catch {
            print("Failed to read JSON data")
        }
    }

    public func testLoad() -> [DoIt] {
        loadDoItsFromDisk()
        return doIts
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
