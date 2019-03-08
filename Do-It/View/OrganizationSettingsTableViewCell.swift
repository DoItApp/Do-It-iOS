//
//  OrganizationSettingsTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/27/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import UIKit

protocol OrganizationSettingsTableViewCellDelegate: AnyObject {
    func organizationSettingsTableViewCellDidUpdate(_ cell: OrganizationSettingsTableViewCell)
}

class OrganizationSettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segments: UISegmentedControl!

    weak var delegate: OrganizationSettingsTableViewCellDelegate?

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

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate?.organizationSettingsTableViewCellDidUpdate(self)
    }

}

protocol PrioritySettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectPriority(_ cell: PrioritySettingSegmentTableViewCell)
}

class PrioritySettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItPriority: DoItPriority?

    func selectSegment(sender: UISegmentedControl) {
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

        delegate?.organizationSettingsTableViewCellDidUpdate(self)
    }
}

protocol GroupSettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectGrouping(_ cell: GroupSettingSegmentTableViewCell)
}

class GroupSettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItGroupSetting: GroupingSetting?

    func selectSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            doItGroupSetting = nil
        case 1:
            doItGroupSetting = .dueDate
        case 2:
            doItGroupSetting = .course
        case 3:
            doItGroupSetting = .priority
        default:
            fatalError()
        }

        delegate?.organizationSettingsTableViewCellDidUpdate(self)
    }
}

protocol SortSettingSegmentTableViewCellDelegate: AnyObject {
    func didSelectSort(_ cell: SortSettingSegmentTableViewCell)
}

class SortSettingSegmentTableViewCell: OrganizationSettingsTableViewCell {
    var doItSortSetting: SortSetting?

    func selectSegment(sender: UISegmentedControl) {
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

        delegate?.organizationSettingsTableViewCellDidUpdate(self)
    }

}
