//
//  GroupSettingSegmentTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import Foundation

protocol GroupSettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectGrouping(_ cell: GroupSettingSegmentTableViewCell)
}

class GroupSettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItGroupSetting: GroupingSetting {
        get {
            return GroupingSetting(rawValue: segments.selectedSegmentIndex)!
        }
        set {
            segments.selectedSegmentIndex = newValue.rawValue
        }
    }
    weak var delegate: GroupSettingSegmentTableViewCellDelegate?

    @IBAction override func selectSegment(sender: UISegmentedControl) {
        delegate?.didSelectGrouping(self)
    }
}
