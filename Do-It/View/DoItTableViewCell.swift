//
//  DoItTableViewCell.swift
//  Do-It
//
//  Created by Aaron on 1/17/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

class DoItTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    @IBOutlet var priorityView: UIView! {
        didSet {
            priorityView.layer.cornerRadius = priorityView.frame.size.width/2
            priorityView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPriorityAccentColor(_ color: UIColor) {
        priorityView.backgroundColor = color
    }
}
