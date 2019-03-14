//
//  SortSettingSegmentTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import Foundation

protocol SortSettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectSort(_ cell: SortSettingSegmentTableViewCell)
}

class SortSettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItSortSetting: SortSetting? {
        get {
            return SortSetting(rawValue: segments.selectedSegmentIndex - 1)
        }
        set {
            if let newValue = newValue {
                segments.selectedSegmentIndex = newValue.rawValue + 1
            } else {
                segments.selectedSegmentIndex = 0
            }
        }
    }

    weak var delegate: SortSettingSegmentTableViewCellDelegate?

    @IBAction override func selectSegment(sender: UISegmentedControl) {
        delegate?.didSelectSort(self)
    }
}
