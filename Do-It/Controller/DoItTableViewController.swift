//
//  DoItTableViewController.swift
//  Do-It
//
//  Created by Aaron on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

class DoItTableViewController: UITableViewController {
    // add fake DoIt data
    var doits = [DoIt]()

    override func viewWillAppear(_ animated: Bool) {

        // JUST FOR TESTING
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

        let toolBar = UIToolbar()
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        )
        items.append(
            // UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapsOnAdd))
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(testFunction))
        )
        toolBar.setItems(items, animated: true)
        toolBar.tintColor = .red
        view.addSubview(toolBar)

        toolBar.translatesAutoresizingMaskIntoConstraints = false

        let guide = self.view.safeAreaLayoutGuide
        toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }

    @objc func testFunction(){
        print("yoooo")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        //tableView.delegate = self
        //tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
                                commit editingStyle: UITableViewCellEditingStyle,
                                forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array,
            // and add a new row to the table view
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
