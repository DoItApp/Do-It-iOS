//
//  DoItSharingManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

final class DoItSharingManager {
    var persistenceManager: DoItPersistenceManager

    init(persistenceManager: DoItPersistenceManager) {
        self.persistenceManager = persistenceManager
    }

    func send(_ doIts: [DoIt]) {

    }

    func receive(_ doItData: Data) {

    }
}
