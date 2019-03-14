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

