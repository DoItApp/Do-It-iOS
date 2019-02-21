//
//  DoItSharingManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

final class DoItSharingManager {
    var persistenceManager: DoItPersistenceManager?

    static let shared = DoItSharingManager()

    private var observers: [ObjectIdentifier: DoItSharingObserver] = [:]

    func addObserver(_ observer: DoItSharingObserver) {
        let identifier = ObjectIdentifier(observer)
        observers[identifier] = observer
    }

    func removeObserver(_ observer: DoItSharingObserver) {
        let identifier = ObjectIdentifier(observer)
        observers.removeValue(forKey: identifier)
    }

    private func notifyObservers(forReceptionOf doIts: [DoIt]) {
        for observer in observers.values {
            observer.sharingManager(self, didReceiveDoIts: doIts)
        }
    }

    private init() { }

    func send(_ doIts: [DoIt]) {

    }

    func receive(_ doItData: Data) {

    }
}
