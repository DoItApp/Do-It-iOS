//
//  PersistenceManager.swift
//  Do-ItCore
//
//  Created by Michael Pangburn on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public protocol PersistenceManager: AnyObject {
    associatedtype ManagedDatum: Codable

    var encoder: Encoder { get }
    var decoder: Decoder { get }
    var fileManager: FileManager { get }
    var savedFileName: String { get }

    var managedData: [ManagedDatum] { get set }
}

// MARK: - Default implementations
extension PersistenceManager {
    public var fileManager: FileManager {
        return .default
    }
}

// MARK: - Extension methods
extension PersistenceManager {
    private var documentsURL: URL {
        do {
            return try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            fatalError("The application will always have a documents directory available")
        }
    }

    private var savedFileURL: URL {
        return documentsURL.appendingPathComponent(savedFileName)
    }

    func loadFromDisk() {
        do {
            let data = try Data(contentsOf: savedFileURL, options: [])
            managedData = try decoder.decode([ManagedDatum].self, from: data)
        } catch {
            print("\(error): failed to read data from \(savedFileURL)")
        }
    }

    func testLoad() -> [ManagedDatum] {
        loadFromDisk()
        return managedData
    }

    public func save(_ data: ManagedDatum) {
        managedData.append(data)
    }

    func saveToDisk() {
        do {
            let data = try encoder.encode(managedData)
            try data.write(to: savedFileURL, options: [])
        } catch {
            print("\(error): failed to save data to \(savedFileURL)")
        }
    }
}
