//
//  DoItPersistenceManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation


final class DoItPersistenceManager {
    var doIts: [DoIt] {
        didSet {
            saveDoItsToDisk()
        }
    }

    init() {
        doIts = DoItPersistenceManager.loadDoItsFromDisk()
    }

    func save(_ doIt: DoIt) {

    }

    func update(_ doIt: DoIt) {

    }

    func delete(_ doIt: DoIt) {

    }

    private static func loadDoItsFromDisk() -> [DoIt] {
        fatalError("not implemented")
    }

    private func saveDoItsToDisk() {

    }
}
