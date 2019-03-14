//
//  OrganizationSettingsTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/27/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import UIKit

class OrganizationSettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segments: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTitles(titles: [String]) {
        var ind: Int = 0
        for title in titles {
            segments.setTitle(title, forSegmentAt: ind)
            ind += 1
        }
    }

    func removeLastSegment() {
        segments.removeSegment(at: 3, animated: false)
    }

    @IBAction private func segmentChanged(sender: UISegmentedControl) {
        selectSegment(sender: sender)
    }

    func selectSegment(sender: UISegmentedControl) {
    }

}

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
