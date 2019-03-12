//
//  DoItOrganizationManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public final class DoItOrganizationManager {
    var organizationSettings: DoItOrganizationSettings
    let dateFormatter = DateFormatter()

    public init(organizationSettings: DoItOrganizationSettings) {
        self.organizationSettings = organizationSettings
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }

    public func organize(_ doIts: [DoIt]) -> [(String, [DoIt])] {
        var beingOrganized = doIts
        let filterAlg = DoItsFilter()
        for filterType in organizationSettings.filterSetting {
            beingOrganized = filterAlg.filter(beingOrganized, filterType: filterType)
        }
        let sortAlg = DoItSort()
        var groupedDoIts = groupDoIts(beingOrganized)
        if let sort = organizationSettings.sortSetting {
            for index in groupedDoIts.indices {
                groupedDoIts[index].1 = sortAlg.sortBy(setting: sort,
                                                       unsortedList: groupedDoIts[index].1)
            }
        }
        return groupedDoIts
    }

    private func groupDoIts(_ doIts: [DoIt]) -> [(String, [DoIt])] {
        let groupAlg = DoItGroup()
        var groupedDoIts = [(String, [DoIt])]()
        switch organizationSettings.groupingSetting {
        case .dueDate:
            let doIts = groupAlg.groupByDate(ungroupedList: doIts)
            for group in doIts {
                groupedDoIts.append((dateFormatter.string(from: group.key), group.value))
            }
        case .course:
            groupedDoIts = groupAlg.groupByCourse(ungroupedList: doIts)
        case .priority:
            let doIts = groupAlg.groupByPriority(ungroupedList: doIts)
            for group in doIts {
                switch group.key {
                case .low:
                    groupedDoIts.append(("Low", group.value))
                case .default:
                    groupedDoIts.append(("Medium", group.value))
                case .high:
                    groupedDoIts.append(("High", group.value))
                }
            }
        }
        return groupedDoIts
    }
}
