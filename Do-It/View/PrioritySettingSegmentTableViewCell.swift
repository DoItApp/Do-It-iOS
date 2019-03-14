//
//  PrioritySettingSegmentTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import Foundation

protocol PrioritySettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectPriority(_ cell: PrioritySettingSegmentTableViewCell)
}

class PrioritySettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItPriority: DoItPriority? {
        get {
            return DoItPriority(rawValue: segments.selectedSegmentIndex - 1)
        }
        set {
            if let newValue = newValue {
                segments.selectedSegmentIndex = newValue.rawValue + 1
            } else {
                segments.selectedSegmentIndex = 0
            }
        }
    }

    weak var delegate: PrioritySettingSegmentTableViewCellDelegate?

    @IBAction override func selectSegment(sender: UISegmentedControl) {
        delegate?.didSelectPriority(self)
    }
}
