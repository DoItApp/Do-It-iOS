//
//  DoItTableViewController.swift
//  Do-It
//
//  Created by Aaron on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class DoItTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var doIts = [DoIt]()
    @IBOutlet var tableView: UITableView!
    let formatter = DateComponentsFormatter()

    override func viewWillAppear(_ animated: Bool) {

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "fake"),
                          dueDate: Calendar.current.date(byAdding: .day, value: 30, to: Date())!,
                          description: "description here",
                          name: "YO",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doIts.append(DoIt(identifier: DoItId(),
                          course: Course(name: "fake"),
                          dueDate: Calendar.current.date(byAdding: .hour, value: 20, to: Date())!,
                          description: "description here",
                          name: "YO",
                          priority: DoItPriority.low,
                          kind: DoItKind.homework))

        doIts.append(DoIt(identifier: DoItId(),
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
        return doIts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoItTableViewCell",
                                                       for: indexPath) as? DoItTableViewCell else {
            fatalError("The TableViewCell could not be cast to DoItTableViewCell")
        }

        cell.titleLabel?.text = doIts[indexPath.item].name
        cell.courseLabel?.text = doIts[indexPath.item].course.name
        cell.dateLabel?.text = formattedDate(index: indexPath.item)
        cell.descriptionLabel?.text = doIts[indexPath.item].description

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

}

// Methods called when buttons pressed
extension DoItTableViewController {

    @IBAction func editButtonPressed() {
        // IMPLEMENT ME
        print("edit button pressed")
    }

    @IBAction func searchButtonPressed() {
        // IMPLEMENT ME
        print("search button pressed")
    }

    @IBAction func composeButtonPressed() {
        // IMPLEMENT ME
        print("compose button pressed")
    }

}
