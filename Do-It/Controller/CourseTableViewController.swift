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
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourses courses: [Course])
}

extension CourseTableViewControllerDelegate {
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourse course: Course) {

    }
    func courseTableViewController(_ courseVC: CourseTableViewController, didSelectCourses courses: [Course]) {

    }
}

class CourseTableViewController: UIViewController {

    let persistenceManager = CoursePersistenceManager.shared

    var visCourses = [Course]()

    var courses: [Course] {
        return persistenceManager.courses
    }

    enum SelectMode {
        case one
        case multiple
    }

    var selectMode: SelectMode = .multiple {
        didSet {
            switch selectMode {
            case .one:
                selectedIndexPaths.removeAll()
                // Off-screen cells will have checkmark when dequeued in `tableView(_:cellForRowAt:)`
                for case let cell as DoItTableViewCell in tableView.visibleCells {
                    cell.checkmarkImageView.isHidden = true
                }
            case .multiple:
                navigationBarEditItem.setRightBarButtonItems([doneBarButtonItem], animated: true)
            }
        }
    }

    private lazy var doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                         action: #selector(doneButtonPressed))

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBarEditItem: UINavigationItem!

    weak var delegate: CourseTableViewControllerDelegate?

    private var selectedIndexPaths: Set<IndexPath> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"

        visCourses = courses

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
        //
        guard let cell = tableView.cellForRow(at: indexPath) as? CourseTableViewCell else {
            return
        }
        switch selectMode {
        case .one:
            // Send this back to Do-It  screen
            delegate?.courseTableViewController(self, didSelectCourse: course)
            navigationController?.popViewController(animated: true)
        case .multiple:
            // Toggle selected cell for sharing
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.remove(indexPath)
            } else {
                selectedIndexPaths.insert(indexPath)
            }
            cell.checkImage.isHidden.toggle()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

// MARK: - Methods called when buttons pressed
extension CourseTableViewController {

    @objc private func doneButtonPressed() {
        let coursesToSendBack = selectedIndexPaths.map { visCourses[$0.row]}
        delegate?.courseTableViewController(self, didSelectCourses: coursesToSendBack)
        dismiss(animated: true)
        selectMode = .one
    }

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

    @IBAction func composeButtonPressed(_ sender: UIBarButtonItem) {
        print("got here")
        let (parentNavigationVC, createCourseVC) = CourseCreationViewController.instantiateFromStoryboard()
        createCourseVC.delegate = self
        present(parentNavigationVC!, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = visCourses.remove(at: indexPath.row)
            persistenceManager.deleteCourse(matching: removed.name)
            visCourses = courses
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
