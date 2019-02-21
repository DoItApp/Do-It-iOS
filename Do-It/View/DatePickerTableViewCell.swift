//  Date Picker Table View Cell
//  DatePickerTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/12/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

protocol DatePickerTableViewCellDelegate: AnyObject {
    func datePickerTableViewCellDidUpdateDate(_ cell: DatePickerTableViewCell)
}

class DatePickerTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!

    weak var delegate: DatePickerTableViewCellDelegate?

    var date: Date {
        get {
            return datePicker.date
        }
        set {
            datePicker.date = newValue
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

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        delegate?.datePickerTableViewCellDidUpdateDate(self)
    }
}
