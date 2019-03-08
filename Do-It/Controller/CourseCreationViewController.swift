//
//  CourseCreationViewController.swift
//  Do-It
//
//  Created by Adam Berard on 3/5/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

protocol CourseCreationViewControllerDelegate: AnyObject {
    func courseCreationViewController(_ viewController: CourseCreationViewController, didSaveCourse course: Course)
}

class CourseCreationViewController: UIViewController {

    weak var delegate: CourseCreationViewControllerDelegate?

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
        dismiss(animated: true)
    }

    @IBAction func saveButtonPressed() {
        if let courseTitle = courseTitleTextField.text, courseTitle != "" {
            print("course title: '" + courseTitle + "'")
            let course = Course(name: courseTitle)
            delegate?.courseCreationViewController(self, didSaveCourse: course)
            dismiss(animated: true)
        } else {
            let alertController = UIAlertController(title: "Hey!",
                                                    message: "You didn't put a course title.",
                                                    preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,
                                                    handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

// optional unwarpping if let

}
