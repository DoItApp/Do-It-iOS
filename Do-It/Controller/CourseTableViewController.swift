//
//  CourseTableViewController.swift
//  Do-It
//
//  Created by Adam Berard on 2/20/19.
//  Copyright @ 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

protocol CourseTableViewControllerDelegate: AnyObject {
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourse course: Course)
}

class CourseTableViewController: UIViewController {

    let persistenceManager = CoursePersistenceManager.shared

    var visCourses = [Course]()

    var courses: [Course] {
        return persistenceManager.courses
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBarEditItem: UINavigationItem!

    weak var delegate: CourseTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"

        visCourses.append(contentsOf: createArray())

        visCourses.sort { (lhs: Course, rhs: Course) -> Bool in
            return lhs.name < rhs.name
        }

        navigationBarEditItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(editButtonPressed))

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
        return visCourses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = visCourses[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell") as? CourseTableViewCell else {
                fatalError("The TableViewCell could not be cast to CourseTableViewCell")
        }

        cell.setUpCell(course: course)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = visCourses[indexPath.row]
        delegate?.courseTableViewController(self, didSelectCourse: course)
        navigationController?.popViewController(animated: true)
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
            visCourses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
}

// MARK: - Navigation
extension CourseTableViewController: CourseCreationViewControllerDelegate {
    func courseCreationViewController(_ viewController: CourseCreationViewController, didSaveCourse course: Course) {
        persistenceManager.save(course)
        visCourses = courses
        tableView.reloadData()
    }
}
