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
        docsURL = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        doItsURL = docsURL.appendingPathComponent("DoIts.json")
        doIts = DoItPersistenceManager.loadDoItsFromDisk()
    }
    
    // ask Michael what these functions should do exactly
    func save(_ doIt: DoIt) {
        
    }

    func update(_ doIt: DoIt) {

    }

    func delete(_ doIt: DoIt) {

    }

    private static func loadDoItsFromDisk() -> [DoIt] {
        // Read data from .json file and transform data into an array
        do {
            let docsURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let doItsURL = docsURL.appendingPathComponent("DoIts.json")
            let data = try Data(contentsOf: doItsURL, options: [])
            let doItsArray =  try JSONSerialization.jsonObject(with: data, options: []) as! [DoIt]
            return doItsArray
        } catch {
            print("Failed to read JSON data")
            return []
        }
    }
    
    private func saveDoItsToDisk() {
        do {
            let data = try JSONSerialization.data(withJSONObject: doIts, options: [])
            try data.write(to: doItsURL, options: [])
        } catch {
            print("Failed to write JSON data")
        }
    }
}
