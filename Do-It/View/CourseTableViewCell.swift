//
//  CourseTableViewCell.swift
//  Do-It
//
//  Created by Adam Berard on 2/20/19.
//  Copyright @ 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class CourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseColorView: UIView! {
        didSet {
            courseColorView.layer.cornerRadius = courseColorView.frame.size.width/2
            courseColorView.clipsToBounds = true
            courseColorView.backgroundColor = .randomPastel()
        }
    }

    func setUpCell(course: Course) {
        courseNameLabel.text = course.name
    }

}

extension UIColor {

    static func randomPastel() -> UIColor {
        return UIColor(hue: .random(in: 0...1),
                       saturation: 1.0,
                       brightness: .random(in: 0.75...0.9),
                       alpha: 1.0)
    }

    static func randomColor() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1)
    }
}
