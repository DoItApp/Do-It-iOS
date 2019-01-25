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
    // add creating file if it does not already exist
    init() {
        docsURL = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        doItsURL = docsURL.appendingPathComponent("DoIts.json")
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
        //let data = encoder.encode(doIts)

    }
}
