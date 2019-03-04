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
                                          didSelectTimeRange range: DateInterval?)
}

class DueDatePickerTableViewController: UITableViewController {

    var timeRangeSelected: DateInterval?

    struct Option {

        let index: Int
        let name: String
        let dateRange: DateInterval

        init(row: Int, description: String, range: DateInterval) {
            index = row
            name = description
            dateRange = range
        }
    }

    var options: [Option] = []

    weak var delegate: DueDatePickerTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTimeOptions()
    }

    func makeTimeOptions() {

        var components = DateComponents()
        components.day = 1
        components.second = -1

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: components, to: startOfDay)!
        let endOfTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: endOfDay)!

        options.append(Option(row: 0,
                              description: "Today",
                              range: DateInterval(start: Date(), end: endOfDay)))
        options.append(Option(row: 1,
                              description: "Tomorrow",
                              range: DateInterval(start: endOfDay, end: endOfTomorrow)))
        options.append(Option(row: 2,
                              description: "Within the next Three Days",
                              range: DateInterval(start: Date(),
                                                  end: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)))
        options.append(Option(row: 3,
                              description: "Within the next Week",
                              range: DateInterval(start: Date(),
                                                  end: Calendar.current.date(byAdding: .day, value: 7, to: Date())!)))

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DueDateCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.item].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timeRangeSelected = options[indexPath.row].dateRange
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }

    @IBAction func done(_ sender: Any) {
        // this calls a funcction in createDoItViewController,
        // do something similar for the organization view controller
        // delegate?.createDoItViewController(self, didSaveDoIt: doIt)
        delegate?.dueDatePickerTableViewController(self, didSelectTimeRange: timeRangeSelected)
        dismiss(animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
     commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class,
     // insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
