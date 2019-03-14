//
//  CreateDoItTableViewController.swift
//  Do-It
//
//  Created by Cesar F. Chacon on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

protocol CreateDoItTableViewControllerDelegate: AnyObject {
    func createDoItViewController(_ viewController: CreateDoItTableViewController, didSaveDoIt doIt: DoIt)
    func createDoItViewController(_ viewController: CreateDoItTableViewController, didEditDoIt doIt: DoIt)
}

class CreateDoItTableViewController: UITableViewController {
    enum Row: Int, CaseIterable {
        case name
        case course
        case priority
        case description
        case datePicker
        case alertOption
    }

    enum InputMode {
        case addNewDoIt
        case editDoIt(DoIt)
    }

    var inputMode: InputMode!

    var course = Course(name: "")
    var desc = ""
    var name = ""
    var priority = DoItPriority.default
    var date = Date()
    var alertOption: DateComponents?
    var alertString = ""

    weak var delegate: CreateDoItTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNibs(for: DatePickerTableViewCell.self,
                                 TextFieldTableViewCell.self,
                                 PriorityPickerTableViewCell.self)
        tableView.register(DetailTextTableViewCell.self, forCellReuseIdentifier: DetailTextTableViewCell.className)

        switch inputMode {
        case .addNewDoIt?:
            title = "New Do-It"
        case .editDoIt(let doItToEdit)?:
            title = "Edit Do-It"
            populateViewWithDoItToEdit(doIt: doItToEdit)
        case .none:
            fatalError("InputMode not set!")
        }

    }

    func populateViewWithDoItToEdit(doIt: DoIt) {
        name = doIt.name
        desc = doIt.description
        course = doIt.course
        priority = doIt.priority
        date = doIt.dueDate
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .name:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: TextFieldTableViewCell.self)
            cell.titleLabel.text = "Name"
            cell.textField.text = name
            cell.delegate = self
            return cell
        case .course:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DetailTextTableViewCell.self)
            cell.textLabel?.text = "Course"
            cell.detailTextLabel?.text = course.name
            cell.accessoryType = .disclosureIndicator
            return cell
        case .priority:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: PriorityPickerTableViewCell.self)
            cell.segmentControl.selectedSegmentIndex = priority.rawValue - 1
            cell.delegate = self
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: TextFieldTableViewCell.self)
            cell.titleLabel.text = "Description"
            cell.textField.text = desc
            cell.delegate = self
            return cell
        case .datePicker:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DatePickerTableViewCell.self)
            cell.titleLabel.text = "Date Picker"
            cell.datePicker.minimumDate = Date()
            cell.date = date
            cell.delegate = self
            return cell
        case .alertOption:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DetailTextTableViewCell.self)
            cell.textLabel?.text = "When to alert"
            cell.detailTextLabel?.text = alertString
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = tableView.cellForRow(at: indexPath)
        switch Row(rawValue: indexPath.row)! {
        case .course:
            guard case (nil, let courseVC) = CourseTableViewController.instantiateFromStoryboard() else {
                fatalError("Navigation controller should not be attached in CourseTableViewController.storyboard")
            }
            courseVC.delegate = self
            show(courseVC, sender: sender)
        case .alertOption:
            guard case (nil, let alertVC) = AlertDateTableViewController.instantiateFromStoryboard() else {
                fatalError("Navigation controller should not be attached in AlertDateTableViewController.storyboard")
            }
            alertVC.delegate = self
            show(alertVC, sender: sender)
        default:
            break
        }
    }

    @IBAction func save(_ sender: Any) {
        if course.name == "" || name == "" {
            let alertController = UIAlertController(title: "You're not done yet!",
                                                    message: "Please fill in all the required fields before adding the Do-It", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            var doIt = DoIt(course: course, dueDate: date, description: desc,
                            name: name, priority: priority, kind: .homework)
            let notifManager = NotificationManager()
            switch inputMode {
            case .addNewDoIt?:
                delegate?.createDoItViewController(self, didSaveDoIt: doIt)
                notifManager.setTrigger(doIt, alertOption)
            case .editDoIt(let doItToEdit)?:
                notifManager.reschedule(doIt, alertOption)
                doIt.identifier = doItToEdit.identifier
                delegate?.createDoItViewController(self, didEditDoIt: doIt)
            case .none:
                fatalError("inputMode is not set!")
            }
            dismiss(animated: true)
        }
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CreateDoItTableViewController: TextFieldTableViewCellDelegate {
    func textFieldTableViewCellDidUpdateText(_ cell: TextFieldTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .name:
            name = (cell.textField?.text)!
        case .description:
            desc = (cell.textField?.text)!
        default:
            fatalError("Not an option")
        }
    }
}

extension CreateDoItTableViewController: DatePickerTableViewCellDelegate {
    func datePickerTableViewCellDidUpdateDate(_ cell: DatePickerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .datePicker:
            date = (cell.date)

        default:
            fatalError()
        }
    }
}

extension CreateDoItTableViewController: PriorityPickerTableViewCellDelegate {
    func priorityPickerTableViewCellDidUpdatePriority(_ cell: PriorityPickerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .priority:
            priority = cell.doItPriority
        default:
            fatalError()
        }
    }
}

extension CreateDoItTableViewController: CourseTableViewControllerDelegate {
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourse course: Course) {
        self.course = course
        tableView.reloadRows(at: [IndexPath(row: Row.course.rawValue, section: 0)], with: .automatic)
    }
}

extension CreateDoItTableViewController: AlertDateTableViewControllerDelegate {
    func alertDateTableViewController(_ alertVC: AlertDateTableViewController,
                                      didSelectDate alertWhen: (DateComponents, String)?) {
        let tuple = alertWhen!
        self.alertString = tuple.1
        self.alertOption = tuple.0
        tableView.reloadRows(at: [IndexPath(row: Row.alertOption.rawValue, section: 0)], with: .automatic)
    }
}
