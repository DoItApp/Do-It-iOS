//
//  DoItOrganizationManager.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

//date formatter

public final class DoItOrganizationManager {
    var organizationSettings: DoItOrganizationSettings

    init(organizationSettings: DoItOrganizationSettings) {
        self.organizationSettings = organizationSettings
    }

    func organize(_ doIts: [DoIt]) -> [(String, [DoIt])] {
        //let filterAlg = DoItsFilter() do filtering once that is sorted out
        let sortAlg = DoItSort()
        var organizeDoIts = groupDoIts(doIts)
        for index in 0...organizeDoIts.count - 1 {
            organizeDoIts[index].1 = sortAlg.sortBy(setting: organizationSettings.sortSetting,
                                                    unsortedList: organizeDoIts[index].1)
        }
        return organizeDoIts
    }

    private func groupDoIts(_ doIts: [DoIt]) -> [(String, [DoIt])] {
        let groupAlg = DoItGroup()
        var groupedDoIts = [(String, [DoIt])]()
        switch organizationSettings.groupingSetting {
        case .dueDate:
            // problem here, date doesnt show time but same day diff time causes sorting into different blocks
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
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
                    groupedDoIts.append(("low", group.value))
                case .default:
                    groupedDoIts.append(("medium", group.value))
                case .high:
                    groupedDoIts.append(("high", group.value))
                }
            }
        }
        return groupedDoIts
    }
}
