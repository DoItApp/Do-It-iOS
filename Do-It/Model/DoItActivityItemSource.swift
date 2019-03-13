//
//  DoItActivityItemSource.swift
//  Do-It
//
//  Created by Michael Pangburn on 3/5/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

final class DoItActivityItemSource: NSObject, UIActivityItemSource {
    private static let customDataUTI = "com.spu.doitUTI.doit"

    let doIts: [DoIt]

    init(doIts: [DoIt]) {
        assert(!doIts.isEmpty)
        self.doIts = doIts
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        // Inform the activity view controller that Data is being sent by passing this placeholder.
        return Data()
    }

    func activityViewController(_ activityViewController: UIActivityViewController,
                                itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        do {
            return try JSONEncoder().encode(doIts)
        } catch {
            print("Do-It encoding failed:", error)
            return Data()
        }
    }

    func activityViewController(_ activityViewController: UIActivityViewController,
                                dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        return type(of: self).customDataUTI
    }
}
