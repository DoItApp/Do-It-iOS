//
//  DueDatePickerTableViewController.swift
//  Do-It
//
//  Created by Aaron on 2/21/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

protocol DueDatePickerTableViewControllerDelegate: AnyObject {
    func dueDatePickerTableViewController(_ viewController: DueDatePickerTableViewController,
                                          didSelectTimeRange range: (DateComponents, DateComponents)?)
}

class DueDatePickerTableViewController: UITableViewController {

    var timeRangeSelected: (rangeStartOffset: DateComponents, rangeEndOffset: DateComponents)?
    var previousIndexPath: IndexPath?

    struct Option {
        let name: String
        let dateBegin: DateComponents
        let dateEnd: DateComponents

        init(description: String, begin: DateComponents, end: DateComponents) {
            name = description
            dateBegin = begin
            dateEnd = end
        }
    }

    var options: [Option] = []

    weak var delegate: DueDatePickerTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTimeOptions()
    }

    func makeTimeOptions() {

        var currentTimeComponent = DateComponents()
        currentTimeComponent.day = 0
        currentTimeComponent.second = 0

        var endOfDayComponent = DateComponents()
        endOfDayComponent.day = 1
        endOfDayComponent.second = -1

        var endOfTomorrowComponent = DateComponents()
        endOfTomorrowComponent.day = 2
        endOfTomorrowComponent.second = -1

        var endOfThreeDaysComponent = DateComponents()
        endOfThreeDaysComponent.day = 4
        endOfThreeDaysComponent.second = -1

        var endOfWeekComponent = DateComponents()
        endOfWeekComponent.day = 8
        endOfWeekComponent.second = -1

        options.append(Option(description: "Today",
                              begin: currentTimeComponent,
                              end: endOfDayComponent))
        options.append(Option(description: "Tomorrow",
                              begin: endOfDayComponent,
                              end: endOfTomorrowComponent))
        options.append(Option(description: "Within the next three days",
                              begin: currentTimeComponent,
                              end: endOfThreeDaysComponent))
        options.append(Option(description: "Within the next week",
                              begin: currentTimeComponent,
                              end: endOfWeekComponent))

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DueDateCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row].name

        if let range = timeRangeSelected {
            if range.0 == options[indexPath.row].dateBegin &&
                    range.1 == options[indexPath.row].dateEnd {
                cell.accessoryType = .checkmark
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {

            if cell.accessoryType == .none {
                clearPreviousCell()
                cell.accessoryType = .checkmark
                previousIndexPath = indexPath
                saveUserSelection(forIndexPath: indexPath)
            } else {
                clearCurrentCell(forCell: cell)
            }

        }
    }

    func clearPreviousCell() {
        if let path = previousIndexPath {
            if let oldCell = tableView.cellForRow(at: path) {
                oldCell.accessoryType = .none
            }
        }
    }

    func saveUserSelection(forIndexPath indexPath: IndexPath) {
        timeRangeSelected = (options[indexPath.row].dateBegin, options[indexPath.row].dateEnd)
    }

    func clearCurrentCell(forCell cell: UITableViewCell) {
        cell.accessoryType = .none
        timeRangeSelected = nil
    }

    // MARK: - Navigation
    @IBAction func done(_ sender: Any) {
        delegate?.dueDatePickerTableViewController(self, didSelectTimeRange: timeRangeSelected)
        dismiss(animated: true)
    }

}
