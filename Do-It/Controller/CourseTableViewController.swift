//
//  CourseTableViewController.swift
//  Do-It
//
//  Created by Adam Berard on 2/20/19.
//  Copyright @ 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class CourseTableViewController: UIViewController, UISearchBarDelegate {

    var courses = [Course]()
    var filteredCourses = [Course]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBarEditItem: UINavigationItem!
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        courses = createArray()

        courses.sort { (lhs: Course, rhs: Course) -> Bool in
            return lhs.name < rhs.name
        }

        filteredCourses = courses

        navigationBarEditItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(editButtonPressed))

        searchBar  = UISearchBar(frame: CGRect(origin: .zero,
                                               size: CGSize(width: UIScreen.main.bounds.width,
                                                            height: 44)))

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    func createArray() -> [Course] {
        var tempCourses = [Course]()

        tempCourses.append(Course(name: "History"))
        tempCourses.append(Course(name: "Comp Sci"))
        tempCourses.append(Course(name: "Sociology"))
        tempCourses.append(Course(name: "Microbiology"))
        tempCourses.append(Course(name: "Chemistry"))
        tempCourses.append(Course(name: "Algebra"))
        tempCourses.append(Course(name: "Phsyics"))
        tempCourses.append(Course(name: "Geometry"))
        tempCourses.append(Course(name: "Psychology"))
        tempCourses.append(Course(name: "Spanish"))
        tempCourses.append(Course(name: "German"))
        tempCourses.append(Course(name: "French"))
        tempCourses.append(Course(name: "Italian"))
        tempCourses.append(Course(name: "British Literature"))
        tempCourses.append(Course(name: "English Literature"))

        return tempCourses

        }
}

extension CourseTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCourses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = filteredCourses[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseTableViewCell else {
                fatalError("The TableViewCell could not be cast to CourseTableViewCell")
        }

        cell.setUpCell(course: course)

        return cell
    }

}

// MARK: - Methods called when buttons pressed
extension CourseTableViewController {

    @IBAction func editButtonPressed() {
        // IMPLEMENT ME
        print("edit button pressed")

        if navigationBarEditItem.rightBarButtonItem?.title == "Cancel" {
            navigationBarEditItem.rightBarButtonItem?.title = "Edit"
            navigationBarEditItem.title = "Courses"
            navigationBarEditItem.titleView = nil
        } else {
            tableView.setEditing(!tableView.isEditing, animated: true)
            navigationBarEditItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
        }
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            courses.remove(at: indexPath.row)
            filteredCourses = courses
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //        } else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class,
        //        // insert it into the array, and add a new row to the table view.
        //        }
        tableView.reloadData()
    }
}
