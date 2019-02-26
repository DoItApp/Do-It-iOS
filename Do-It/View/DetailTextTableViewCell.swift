//
//  DetailTextTableViewCell.swift
//  Do-It
//
//  Created by Michael Pangburn on 2/26/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

class DetailTextTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        textLabel?.font = .preferredFont(forTextStyle: .body)
        detailTextLabel?.font = .preferredFont(forTextStyle: .body)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
}
