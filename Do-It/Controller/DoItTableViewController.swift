//
//  DoItTableViewController.swift
//  Do-It
//
//  Created by Aaron on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit


class DoItTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var doits = [DoIt]()
    @IBOutlet var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {

        doits.append(DoIt(identifier: DoItId(),
                          course: Course(name: "fake"),
                          dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                          description: "description here",
                          name: "YO",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doits.append(DoIt(identifier: DoItId(),
                          course: Course(name: "fake"),
                          dueDate: Calendar.current.date(byAdding: .hour, value: 20, to: Date())!,
                          description: "description here",
                          name: "YO",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doits.append(DoIt(identifier: DoItId(),
                          course: Course(name: "fake"),
                          dueDate: Calendar.current.date(byAdding: .minute, value: 10, to: Date())!,
                          description: "description here",
                          name: "DIFF",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        tableView.delegate = self
        tableView.dataSource = self

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoItTableViewCell",
                                                       for: indexPath) as? DoItTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "DoItTableViewCell", for: indexPath)
        }

        cell.titleLabel?.text = doits[indexPath.item].name
        cell.courseLabel?.text = doits[indexPath.item].course.name
        cell.dateLabel?.text = formatted_date(index: indexPath.item)
        cell.descriptionLabel?.text = doits[indexPath.item].description

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }

    func formatted_date(index: Int) -> String? {
        let diffDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(),
                                                                 to: doits[index].dueDate)

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day]

        if diffDateComponents.day == 0 && diffDateComponents.hour == 0 {
            formatter.allowedUnits = [.minute]
        } else if diffDateComponents.day == 0 {
            formatter.allowedUnits = [.hour]
        }

        return formatter.string(from: diffDateComponents)
    }

}


// Interacting with button on the screen
extension DoItTableViewController {

    func searchButtonPressed() {
        // IMPLEMENT ME
        print("search button pressed")
    }

    func editButtonPressed() {
        // IMPLEMENT ME
        print("edit button pressed")
    }

    func composeButtonPressed() {
        // IMPLEMENT ME
        print("compose button pressed")
    }

}
