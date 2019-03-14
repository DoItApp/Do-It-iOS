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

    var groupingSetting: GroupingSetting = .course
    var sortSetting: SortSetting?
    var filterSetting: [FilterSpecification] = []

    weak var delegate: OrganizeDoItTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        title = "Organize Do-It"

        tableView.registerNibs(for: CourseTableViewCell.self, PrioritySettingSegmentTableViewCell.self,
                               GroupSettingSegmentTableViewCell.self, SortSettingSegmentTableViewCell.self)
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
//            cell.detailTextLabel?.text = courseSetting?.name
            cell.accessoryType = .disclosureIndicator
            return cell
        case .dueDate:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: DetailTextTableViewCell.self)
            cell.textLabel?.text = "Due Date"
            cell.accessoryType = .disclosureIndicator
            return cell
        case .priority:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: PrioritySettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Priority"
            cell.setTitles(titles: ["None", "Low", "Default", "High"])
            cell.delegate = self
            return cell
        case .sortBy:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: SortSettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Sort By"
            cell.setTitles(titles: ["None", "Due Date", "Course", "Priority"])
            cell.delegate = self
            return cell
        case .groupBy:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: GroupSettingSegmentTableViewCell.self)
            cell.titleLabel?.text = "Group By"
            cell.removeLastSegment()
            cell.setTitles(titles: ["Due Date", "Course", "Priority"])
            cell.delegate = self
            return cell
        }
    }

    @IBAction func save(_ sender: Any) {
        let organizationSettings = DoItOrganizationSettings(groupingSetting: groupingSetting,
                                                sortSetting: sortSetting, filterSetting: filterSetting)
        delegate?.organizeDoItViewController(self, didOrganize: organizationSettings)
        print ("Saved organization settings")
        print (organizationSettings)
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
            courseVC.selectMode = .multiple
            courseVC.delegate = self
            show(courseVC, sender: sender)
        case .dueDate:
            guard case (let parentNavigationVC, let dueDateVC) = DueDatePickerTableViewController.instantiateFromStoryboard() else {
                fatalError("Navigation controller should not be attached in DueDatePickerTableViewController.storyboard")
            }
            dueDateVC.delegate = self
            present(parentNavigationVC!, animated: true)
        default:
            break
        }

    }
}

extension OrganizeDoItTableViewController: CourseTableViewControllerDelegate {
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourse course: Course) {
        filterSetting.append(CourseFilter(course))
    }
    
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourses courses: [Course]) {
        for course in courses {
            filterSetting.append(CourseFilter(course))
        }
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
            filterSetting.append(PriorityFilter(input: cell.doItPriority!))
        default:
            fatalError()
        }
    }
}

extension OrganizeDoItTableViewController: DueDatePickerTableViewControllerDelegate {
    func dueDatePickerTableViewController(_ viewController: DueDatePickerTableViewController,
                                          didSelectTimeRange range: (DateComponents, DateComponents)?) {
        guard range != nil else {
            return
        }
        let calendar = Calendar(identifier: .gregorian)
        let dateBegin: Date = calendar.date(from: ((range?.0)!))!
        let dateEnd: Date = calendar.date(from: ((range?.1)!))!
        filterSetting.append(DueDateFilter(firstDay: dateBegin, lastDay: dateEnd))
    }
}
