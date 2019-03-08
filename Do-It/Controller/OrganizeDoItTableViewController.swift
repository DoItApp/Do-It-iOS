//
//  OrganizeDoItTableViewController.swift
//  Do-It
//
//  Created by Jett Moy on 2/27/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Do_ItCore
import UIKit

protocol OrganizeDoItTableViewControllerDelegate: AnyObject {
    func organizeDoItViewController(_ viewController: OrganizeDoItTableViewController,
                                    didOrganize settings: DoItOrganizationSettings)
}

class OrganizeDoItTableViewController: UITableViewController {
    enum Row: Int, CaseIterable {
        case course
        case dueDate
        case priority
        case sortBy
        case groupBy
    }

    var courseSetting: Course?
    var prioritySetting: DoItPriority?
    var sortSetting: SortSetting?
    var groupingSetting: GroupingSetting?

    weak var delegate: OrganizeDoItTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        title = "New Do-It"

        tableView.registerNibs(for: CourseTableViewCell.self, PrioritySettingSegmentTableViewCell.self, GroupSettingSegmentTableViewCell.self, SortSettingSegmentTableViewCell.self)
        tableView.register(DetailTextTableViewCell.self, forCellReuseIdentifier: DetailTextTableViewCell.className)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .course:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DetailTextTableViewCell.self)
            cell.textLabel?.text = "Course"
            cell.detailTextLabel?.text = courseSetting?.name
            cell.accessoryType = .disclosureIndicator
            return cell
        case .dueDate:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DetailTextTableViewCell.self)
            // TODO: Aaron's due date view here
            return cell
        case .priority:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: PrioritySettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Priority"
            cell.setTitles(titles: ["None", "Low", "Default", "High"])
            cell.delegate = self as? OrganizationSettingsTableViewCellDelegate
            return cell
        case .sortBy:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: SortSettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Sort By"
            cell.setTitles(titles: ["None", "Due Date", "Course", "Priority"])
            cell.delegate = self as? OrganizationSettingsTableViewCellDelegate
            return cell
        case .groupBy:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: GroupSettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Group By"
            cell.setTitles(titles: ["None", "Due Date", "Course", "Priority"])
            cell.delegate = self as? OrganizationSettingsTableViewCellDelegate
            return cell
        }
    }

    @IBAction func save(_ sender: Any) {
//        let organizationSettings = DoItOrganizationSettings(
//                                  courseSetting: courseSetting, dueDateSetting: dueDateSetting, prioritySetting: prioritySetting, groupingSetting: groupingSetting, sortSetting: sortSetting)
//        delegate?.createDoItViewController(self, didOrganize: organizationSettings)
        print("Need to implement")
        dismiss(animated: true)
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    // Course Selection for filter
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = tableView.cellForRow(at: indexPath)
        switch Row(rawValue: indexPath.row)! {
        case .course:
            guard case (nil, let courseVC) = CourseTableViewController.instantiateFromStoryboard() else {
                fatalError("Navigation controller should not be attached in CourseTableViewController.storyboard")
            }
            courseVC.delegate = self
            show(courseVC, sender: sender)
        default:
            break
        }

    }
}

extension OrganizeDoItTableViewController: CourseTableViewControllerDelegate {
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourse course: Course) {
        self.courseSetting = course
        tableView.reloadRows(at: [IndexPath(row: Row.course.rawValue, section: 0)], with: .automatic)
    }
}

extension OrganizeDoItTableViewController: GroupSettingSegmentTableViewCellDelegate {
    func didSelectGrouping(_ cell: GroupSettingSegmentTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .groupBy:
            groupingSetting = cell.doItGroupSetting
        default:
            fatalError("Not an option")
        }
    }
}

extension OrganizeDoItTableViewController: SortSettingSegmentTableViewCellDelegate {
    func didSelectSort(_ cell: SortSettingSegmentTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .sortBy:
            sortSetting = cell.doItSortSetting
        default:
            fatalError("Not an option")
        }
    }

}

extension OrganizeDoItTableViewController: PrioritySettingSegmentTableViewCellDelegate {
    func didSelectPriority(_ cell: PrioritySettingSegmentTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .priority:
            prioritySetting = cell.doItPriority
        default:
            fatalError()
        }
    }
}
