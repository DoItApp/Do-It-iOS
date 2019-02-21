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

    let persistenceManager = DoItPersistenceManager.shared

    let launchDate = Date()
    var doIts: [DoIt] {
        return persistenceManager.doIts.filter { $0.dueDate > launchDate }
    }

    var visibleDoIts: [DoIt] = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationEditItem: UINavigationItem!
    var searchBar: UISearchBar!
    let formatter = DateComponentsFormatter()

    private let mockDoIts: [DoIt] = {
        var doIts: [DoIt] = []
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
        return doIts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(for: DoItTableViewCell.self)

        navigationEditItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(editButtonPressed))

        searchBar  = UISearchBar(frame: CGRect(origin: .zero,
                                               size: CGSize(width: UIScreen.main.bounds.width,
                                                            height: 44)))
        searchBar.delegate = self

        visibleDoIts = doIts
    }
}

// MARK: - Table view data source
extension DoItTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleDoIts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: DoItTableViewCell.self)
        let doIt = visibleDoIts[indexPath.row]

        cell.titleLabel?.text = doIt.name
        cell.courseLabel?.text = doIt.course.name
        cell.dateLabel?.text = formattedDate(doIt.dueDate)
        cell.descriptionLabel?.text = doIt.description

        let priorityAccentColor: UIColor
        switch doIt.priority {
        case .low:
            priorityAccentColor = .green
        case .default:
            priorityAccentColor = .yellow
        case .high:
            priorityAccentColor = .red
        }
        cell.setPriorityAccentColor(priorityAccentColor)

        return cell
    }

    func formattedDate(_ date: Date) -> String? {
        let diffDateComponents = Calendar.current.dateComponents([.day, .hour, .minute],
                                                                 from: Date(),
                                                                 to: date)

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
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = visibleDoIts.remove(at: indexPath.row)
            persistenceManager.deleteDoIt(matching: removed.identifier)
            visibleDoIts = doIts
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

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
        let (parentNavigationVC, createDoItVC) = CreateDoItTableViewController.instantiateFromStoryboard()
        createDoItVC.delegate = self
        present(parentNavigationVC!, animated: true)
    }

}

// Mark: - Search Bar Delegate
extension DoItTableViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        visibleDoIts = searchText.isEmpty ? doIts : doIts.filter { (item: DoIt) -> Bool in
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

extension DoItTableViewController: CreateDoItTableViewControllerDelegate {
    func createDoItViewController(_ viewController: CreateDoItTableViewController, didSaveDoIt doIt: DoIt) {
        persistenceManager.save(doIt)
        visibleDoIts = doIts
        tableView.reloadData()

        // FIXME: We should just use `insertRows` instead of `reloadData` here
//        let lastIndexPath = IndexPath(row: doIts.index(before: doIts.endIndex), section: 0)
//        tableView.insertRows(at: [lastIndexPath], with: .automatic)
    }
}
