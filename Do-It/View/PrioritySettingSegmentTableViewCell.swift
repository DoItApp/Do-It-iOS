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
    var doItPriority: DoItPriority?
    weak var delegate: PrioritySettingSegmentTableViewCellDelegate?
    
    @IBAction override func selectSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            doItPriority = nil
        case 1:
            doItPriority = .low
        case 2:
            doItPriority = .default
        case 3:
            doItPriority = .high
        default:
            fatalError()
        }
        
        delegate?.didSelectPriority(self)
    }
    
}
