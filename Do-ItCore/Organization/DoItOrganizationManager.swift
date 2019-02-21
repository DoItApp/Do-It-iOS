//
//  DoItOrganizationManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

public final class DoItOrganizationManager {
    var organizationSettings: DoItOrganizationSettings

    init(organizationSettings: DoItOrganizationSettings) {
        self.organizationSettings = organizationSettings
    }

    func organize(_ doIts: [DoIt]) -> [DoIt] {
        fatalError("not implemented")
    }
}
