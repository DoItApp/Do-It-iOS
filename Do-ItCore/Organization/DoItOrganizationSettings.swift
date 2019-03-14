//
//  DoItOrganizationSettings.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

public struct DoItOrganizationSettings {
    var groupingSetting: GroupingSetting
    var sortSetting: SortSetting?
    var filterSetting: [FilterSpecification]

    public init(groupingSetting: GroupingSetting, sortSetting: SortSetting?, filterSetting: [FilterSpecification]) {
        self.groupingSetting = groupingSetting
        self.sortSetting = sortSetting
        self.filterSetting = filterSetting
    }
}
