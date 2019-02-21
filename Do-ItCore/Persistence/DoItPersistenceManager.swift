//
//  DoItPersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public final class DoItPersistenceManager {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let fileManager = FileManager.default
    private let docsURL: URL
    private let doItsURL: URL

    public static let shared = DoItPersistenceManager()

    public var doIts: [DoIt] {
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

    public func save(_ doIt: DoIt) {
        doIts.append(doIt)
    }

    @discardableResult
    public func deleteDoIt(matching identifier: DoItId) -> DoIt? {
        guard let index = doIts.firstIndex(where: { $0.identifier == identifier }) else {
            return nil
        }
        return doIts.remove(at: index)
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
