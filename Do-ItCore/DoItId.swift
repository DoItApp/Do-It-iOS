//
//  DoItId.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/29/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public struct DoItId: Codable, Equatable {
    public let identifier: UUID

    public init() {
        self.init(uuid: UUID())
    }

    private init(uuid: UUID) {
        self.identifier = uuid
    }
}
