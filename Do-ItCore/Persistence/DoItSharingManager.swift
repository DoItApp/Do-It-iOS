//
//  DoItSharingManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation


public enum DoItSharingError: Error {
    case unexpectedFileType
    case receivedFileTooLarge
}

public final class DoItSharingManager {
    public static let shared = DoItSharingManager()

    // Files over 10MB are rejected
    private static let maxAcceptedFileSizeInBytes = 10_000_000

    private var observers: [ObjectIdentifier: DoItSharingObserver] = [:]

    public func addObserver(_ observer: DoItSharingObserver) {
        let identifier = ObjectIdentifier(observer)
        observers[identifier] = observer
    }

    public func removeObserver(_ observer: DoItSharingObserver) {
        let identifier = ObjectIdentifier(observer)
        observers.removeValue(forKey: identifier)
    }

    private func notifyObservers(forReceptionOf doIts: [DoIt]) {
        for observer in observers.values {
            observer.sharingManager(self, didReceiveDoIts: doIts)
        }
    }

    private init() { }

    public func receiveDoIts(savedAt fileURL: URL) throws {
        guard let fileSize = try fileURL.resourceValues(forKeys: [.fileSizeKey]).fileSize else {
            throw DoItSharingError.unexpectedFileType
        }

        guard fileSize < DoItSharingManager.maxAcceptedFileSizeInBytes else {
            throw DoItSharingError.receivedFileTooLarge
        }

        let data = try Data(contentsOf: fileURL)
        let doIts = try JSONDecoder().decode([DoIt].self, from: data)
        notifyObservers(forReceptionOf: doIts)
    }
}
