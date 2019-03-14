//
//  PriorityPickerTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//
import Do_ItCore
import UIKit

protocol PriorityPickerTableViewCellDelegate: AnyObject {
    func priorityPickerTableViewCellDidUpdatePriority(_ cell: PriorityPickerTableViewCell)
}

class PriorityPickerTableViewCell: UITableViewCell {

    var doItPriority: DoItPriority {
        get {
            return DoItPriority(rawValue: segmentControl.selectedSegmentIndex)!
        }
        set {
            segmentControl.selectedSegmentIndex = newValue.rawValue
        }
    }

    weak var delegate: PriorityPickerTableViewCellDelegate?

    @IBOutlet var segmentControl: UISegmentedControl!

    @IBAction func selectPriority(sender: UISegmentedControl) {
        delegate?.priorityPickerTableViewCellDidUpdatePriority(self)
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
