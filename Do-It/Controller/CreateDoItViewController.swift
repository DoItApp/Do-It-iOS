//
//  CreateDoItViewController.swift
//  Do-It
//
//  Created by Cesar F. Chacon on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

protocol CreateDoItViewControllerDelegate: AnyObject {
    func createDoItViewController(_ viewController: CreateDoItViewController, didSaveDoIt doIt: DoIt)
}
class CreateDoItViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    enum Row: Int, CaseIterable {
        case name
        case course
        case priority
        case description
        case datePicker
    }

    @IBAction func save(_ sender: Any) {
        let doIt = DoIt(course: course, dueDate: date, description: desc, name: name,
                        priority: priority, kind: .homework)
        delegate?.createDoItViewController(self, didSaveDoIt: doIt)
    }

    var course = Course(name: "Empty")
    var desc: String = ""
    var name: String = ""
    var priority = DoItPriority.default
    var date = Date()
    weak var delegate: CreateDoItViewControllerDelegate?

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.registerNibs(for: DatePickerTableViewCell.self,
                                 TextFieldTableViewCell.self, PriorityPickerTableViewCell.self)
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .name:
            let cell = myTableView.dequeueReusableCell(for: indexPath, as: TextFieldTableViewCell.self)
            cell.titleLabel.text = "Name"
            cell.delegate = self
            return cell
        case .course:
            let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Course"
            return cell
        case .priority:
            let cell = myTableView.dequeueReusableCell(for: indexPath, as: PriorityPickerTableViewCell.self)
            cell.delegate = self
            return cell
        case .description:
            let cell = myTableView.dequeueReusableCell(for: indexPath, as: TextFieldTableViewCell.self)
            cell.titleLabel.text = "Description"
            cell.delegate = self
            return cell
        case .datePicker:
            let cell = myTableView.dequeueReusableCell(for: indexPath, as: DatePickerTableViewCell.self)
            cell.titleLabel.text = "Date Picker"
            cell.delegate = self
            return cell
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateDoItViewController: TextFieldTableViewCellDelegate {
    func textFieldTableViewCellDidUpdateText(_ cell: TextFieldTableViewCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else {
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

extension CreateDoItViewController: DatePickerTableViewCellDelegate {
    func datePickerTableViewCellDidUpdateDate(_ cell: DatePickerTableViewCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else {
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

extension CreateDoItViewController: PriorityPickerTableViewCellDelegate {
    func priorityPickerTableViewCellDidUpdatePriority(_ cell: PriorityPickerTableViewCell) {
        guard let indexPath = myTableView.indexPath(for: cell) else {
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
