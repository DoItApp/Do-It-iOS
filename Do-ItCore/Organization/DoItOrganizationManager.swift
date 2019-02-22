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
        let groupedDoIts = groupDoIts(doIts)

        fatalError("not implemented")
    }

    private func groupDoIts(_ doIts: [DoIt]) -> [(String, [DoIt])] {
        let groupAlg = DoItGroup()
        switch organizationSettings.groupingSetting {
        case .dueDate:
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            var groupedDoIts = groupAlg.groupByDate(ungroupedList: doIts)
        case .course:
            var groupedDoIts = groupAlg.groupByCourse(ungroupedList: doIts)
        case .priority:
            var groupedDoIts = groupAlg.groupByPriority(ungroupedList: doIts)
        }
        return [("hello", [DoIt(identifier: DoItId(), course: Course(name: "ENGR234"),
                               dueDate: Date(timeIntervalSinceReferenceDate: 1500.0),
                               description: "finish hw", name: "test", priority: .high, kind: .test)])]
    }
}
