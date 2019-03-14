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
    var doItGroupSetting: GroupingSetting = .dueDate
    weak var delegate: GroupSettingSegmentTableViewCellDelegate?
    
    @IBAction override func selectSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            doItGroupSetting = .dueDate
        case 1:
            doItGroupSetting = .course
        case 2:
            doItGroupSetting = .priority
        default:
            fatalError()
        }
        
        delegate?.didSelectGrouping(self)
    }
}
