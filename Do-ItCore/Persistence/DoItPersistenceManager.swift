//
//  DoItPersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public final class DoItPersistenceManager: PersistenceManager {
    public let encoder: Encoder = JSONEncoder()
    public let decoder: Decoder = JSONDecoder()

    public let savedFileName = "DoIts.json"

    public static let shared = DoItPersistenceManager()

    public var doIts: [DoIt] = [] {
        didSet {
            saveToDisk()
        }
    }

    private init() {
        loadFromDisk()
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

    /// Fulfills PersistenceManager protocol; equivalent to `doIts` array.
    public var managedData: [DoIt] {
        get {
            return doIts
        }
        set {
            doIts = newValue
        }
    }
}
