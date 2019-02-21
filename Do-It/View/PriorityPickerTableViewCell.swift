//
//  PriorityPickerTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

protocol PriorityPickerTableViewCellDelegate: AnyObject {
    func priorityPickerTableViewCellDidUpdatePriority(_ cell: PriorityPickerTableViewCell)
}

class PriorityPickerTableViewCell: UITableViewCell {

    var doItPriority: DoItPriority = .default

    weak var delegate: PriorityPickerTableViewCellDelegate?

    @IBAction func selectPriority(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            doItPriority = .low
        case 1:
            doItPriority = .default
        case 2:
            doItPriority = .high
        default:
            fatalError()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func priorityChanged(_ sender: UISegmentedControl) {
        delegate?.priorityPickerTableViewCellDidUpdatePriority(self)
    }

}
