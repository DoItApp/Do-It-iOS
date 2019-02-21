//  Date Picker Table View Cell
//  DatePickerTableViewCell.swift
//  Do-It
//
//  Created by Jett Moy on 2/12/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet var selectedDate: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
