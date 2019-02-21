//
//  DoItTableViewController.swift
//  Do-It
//
//  Created by Aaron on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class DoItTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var doIts = [DoIt]()
    var filteredDoIts = [DoIt]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationEditItem: UINavigationItem!
    var searchBar: UISearchBar!
    let formatter = DateComponentsFormatter()

    override func viewWillAppear(_ animated: Bool) {

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 309"),
                          dueDate: Calendar.current.date(byAdding: .minute, value: 10, to: Date())!,
                          description: "description here",
                          name: "HW 1",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 3000"),
                          dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                          description: "description here",
                          name: "Test 2",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "CSC 42"),
                          dueDate: Calendar.current.date(byAdding: .hour, value: 20, to: Date())!,
                          description: "description here",
                          name: "Review 2",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))
        filteredDoIts = doIts

        tableView.delegate = self
        tableView.dataSource = self

        navigationEditItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(editButtonPressed))

        searchBar  = UISearchBar(frame: CGRect(origin: .zero,
                                               size: CGSize(width: UIScreen.main.bounds.width,
                                                            height: 44)))
        searchBar.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Table view data source
extension DoItTableViewController {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return doIts.count
        return filteredDoIts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoItTableViewCell",
                                                       for: indexPath) as? DoItTableViewCell else {
            fatalError("The reusableCell could not be cast to DoItTableViewCell")
        }

        //        cell.titleLabel?.text = doIts[indexPath.item].name
        //        cell.courseLabel?.text = doIts[indexPath.item].course.name
        //        cell.dateLabel?.text = formattedDate(index: indexPath.item)
        //        cell.descriptionLabel?.text = doIts[indexPath.item].description

        cell.titleLabel?.text = filteredDoIts[indexPath.item].name
        cell.courseLabel?.text = filteredDoIts[indexPath.item].course.name
        cell.dateLabel?.text = formattedDate(index: indexPath.item)
        cell.descriptionLabel?.text = filteredDoIts[indexPath.item].description

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func formattedDate(index: Int) -> String? {
        let diffDateComponents = Calendar.current.dateComponents([.day, .hour, .minute],
                                                                 from: Date(),
                                                                 to: doIts[index].dueDate)

        formatter.unitsStyle = .full

        if diffDateComponents.day == 0 && diffDateComponents.hour == 0 {
            formatter.allowedUnits = [.minute]
        } else if diffDateComponents.day == 0 {
            formatter.allowedUnits = [.hour]
        } else {
            formatter.allowedUnits = [.day]
        }

        return formatter.string(from: diffDateComponents)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell number: \(indexPath.row)!")
        // perform segue to detailed view controller
        // self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            doIts.remove(at: indexPath.row)
            filteredDoIts = doIts
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //        } else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class,
        //        // insert it into the array, and add a new row to the table view.
        //        }

        tableView.reloadData()
    }
}

// MARK: - Methods called when buttons pressed
extension DoItTableViewController {

    @objc func editButtonPressed() {

        if navigationEditItem.rightBarButtonItem?.title == "Cancel" {
            navigationEditItem.rightBarButtonItem?.title = "Edit"
            navigationEditItem.title = "Do-Its"
            navigationEditItem.titleView = nil
        } else {
            tableView.setEditing(!tableView.isEditing, animated: true)
            navigationEditItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
        }

    }

    @IBAction func searchButtonPressed() {

            // IMPLEMENT ME
            // present search bar
            // change

        navigationEditItem.titleView = searchBar
        navigationEditItem.title = ""
        navigationEditItem.rightBarButtonItem?.title = "Cancel"
    }

    @IBAction func composeButtonPressed() {
        // IMPLEMENT ME
        // go to addDoItViewController
        print("compose button pressed")
    }

}

// Mark: - Search Bar Delegate
extension DoItTableViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredDoIts = searchText.isEmpty ? doIts : doIts.filter { (item: DoIt) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)

        navigationEditItem.rightBarButtonItem?.title = "Edit"
        navigationEditItem.title = "Do-Its"
        navigationEditItem.titleView = nil
    }

}
