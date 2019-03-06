//
//  CourseCreationViewController.swift
//  Do-It
//
//  Created by Adam Berard on 3/5/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class CourseCreationViewController: UIViewController {

    weak var delegate: CourseTableViewControllerDelegate?

    @IBOutlet weak var courseTitleTextField: UITextField!
    @IBOutlet weak var navBarItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Course Creation"
        navBarItem.title = title
        navBarItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                   style: UIBarButtonItem.Style.plain,
                                                                   target: self,
                                                                   action: #selector(saveButtonPressed))
        navBarItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                       style: UIBarButtonItem.Style.plain,
                                                       target: self,
                                                       action: #selector(cancelButtonPressed))
    }
}

// MARK: - Methods called when buttons pressed
extension CourseCreationViewController {

    @IBAction func cancelButtonPressed() {
        print("cancel button pressed")
        print(courseTitleTextField.text)
    }

    @IBAction func saveButtonPressed() {
        print("save button pressed")
    }

}
