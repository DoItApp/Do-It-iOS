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
    var doItSortSetting: SortSetting?
    weak var delegate: SortSettingSegmentTableViewCellDelegate?
    
    @IBAction override func selectSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            doItSortSetting = nil
        case 1:
            doItSortSetting = .dueDate
        case 2:
            doItSortSetting = .course
        case 3:
            doItSortSetting = .priority
        default:
            fatalError()
        }
        
        delegate?.didSelectSort(self)
    }
    
}
