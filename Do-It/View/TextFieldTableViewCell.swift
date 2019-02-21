//
//  TextFieldTableViewCell.swift
//  Do-It
//
//  Created by Michael Pangburn on 1/17/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

// === INSTRUCTIONS: MAKING A CUSTOM TABLE VIEW CELL ===
// To create a custom table view cell,
// File > New > File > Cocoa Touch Class
// then choose the correct subclass (e.g. UITableViewCell)
// and check the box titled 'Also create XIB file'.

// The created .xib file (see TextFieldTableViewCell.xib)
// gives you space to create the layout for the custom cell.
// To design, read into UI design using storyboards or XIBs,
// including IBOutlet and IBAction.

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textFieldTableViewCellDidUpdateText(_ cell: TextFieldTableViewCell)
}

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField! {
        didSet {
            textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        }
    }

    weak var delegate: TextFieldTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc private func textChanged(_ sender: UITextField) {
        delegate?.textFieldTableViewCellDidUpdateText(self)
    }
}
