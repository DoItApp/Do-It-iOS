//
//  DoItTableViewController.swift
//  Do-It
//
//  Created by Aaron on 1/24/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

class DoItTableViewController: UITableViewController {
    enum InteractionMode {
        case standard
        case selectingToShare
    }

    var interactionMode: InteractionMode = .standard {
        didSet {
            switch interactionMode {
            case .standard:
                navigationItem.setRightBarButtonItems([editBarButtonItem], animated: true)

                selectedIndexPaths.removeAll()
                // Off-screen cells will have checkmark when dequeued in `tableView(_:cellForRowAt:)`
                for case let cell as DoItTableViewCell in tableView.visibleCells {
                    cell.checkmarkImageView.isHidden = true
                }
            case .selectingToShare:
                navigationItem.setRightBarButtonItems([doneBarButtonItem, shareBarButtonItem], animated: true)
            }
        }
    }

    let persistenceManager = DoItPersistenceManager.shared
    let coursePersistenceManager = CoursePersistenceManager.shared

    let launchDate = Date()
    var allDoIts: [DoIt] {
        return persistenceManager.doIts.filter { $0.dueDate > launchDate }
    }

    private lazy var organizationManager = DoItOrganizationManager(
        organizationSettings: DoItOrganizationSettings(
            groupingSetting: .dueDate,
            sortSetting: nil,
            filterSetting: []
        )
    )

    private lazy var doItSections: [(String, [DoIt])] = organizationManager.organize(allDoIts)

    private var selectedIndexPaths: Set<IndexPath> = []

    let formatter = DateComponentsFormatter()

    private lazy var editBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self,
                                                         action: #selector(selectButtonPressed))
    private lazy var shareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                                          action: #selector(shareButtonPressed))
    private lazy var doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                                         action: #selector(doneButtonPressed))

    override func viewDidLoad() {
        super.viewDidLoad()
        let notifManager = NotificationManager()
        notifManager.requestAuthorization()

        DoItSharingManager.shared.addObserver(self)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(for: DoItTableViewCell.self)

        navigationItem.rightBarButtonItem = editBarButtonItem
    }

    private func doIt(at indexPath: IndexPath) -> DoIt {
        let (_, sectionDoIts) = doItSections[indexPath.section]
        return sectionDoIts[indexPath.row]
    }

    private func reorganizeDoIts() {
        doItSections = organizationManager.organize(allDoIts)

        if tableView != nil {
            // `tableView` is `nil` only if the controller hasn't yet been presented on-screen
            tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension DoItTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return doItSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doItSections[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: DoItTableViewCell.self)
        let doIt = self.doIt(at: indexPath)

        cell.titleLabel?.text = doIt.name
        cell.courseLabel?.text = doIt.course.name
        cell.dateLabel?.text = formattedDate(doIt.dueDate)
        cell.descriptionLabel?.text = doIt.description
        cell.checkmarkImageView.isHidden = !isSelected(indexPath)

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

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return doItSections[section].0
    }

    private func isSelected(_ indexPath: IndexPath) -> Bool {
        guard interactionMode == .selectingToShare else {
            return false
        }
        return selectedIndexPaths.contains(indexPath)
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DoItTableViewCell else {
            return
        }
        switch interactionMode {
        case .standard:
            // Proceed to Do-It detail editing screen
            let (parentNavigationVC, createDoItVC) = CreateDoItTableViewController.instantiateFromStoryboard()
            createDoItVC.delegate = self
            let selectedDoIt = doIt(at: indexPath)
            createDoItVC.inputMode = .editDoIt(selectedDoIt)
            present(parentNavigationVC!, animated: true)
        case .selectingToShare:
            // Toggle selected cell for sharing
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.remove(indexPath)
            } else {
                selectedIndexPaths.insert(indexPath)
            }
            cell.checkmarkImageView.isHidden.toggle()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = doItSections[indexPath.section].1.remove(at: indexPath.row)
            persistenceManager.deleteDoIt(matching: removed.identifier)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

        tableView.reloadData()
    }
}

// MARK: - Methods called when buttons pressed
extension DoItTableViewController {

    @objc func selectButtonPressed() {
        interactionMode = .selectingToShare
    }

    @objc private func shareButtonPressed() {
        guard !selectedIndexPaths.isEmpty else {
            return
        }
        let doItsToShare = selectedIndexPaths.map(doIt(at:))
        let activityItem = DoItActivityItemSource(doIts: doItsToShare)
        let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        present(activityViewController, animated: true)
    }

    @objc private func doneButtonPressed() {
        interactionMode = .standard
    }

    @IBAction func searchButtonPressed() {
        // Go to Organization View Controller
        let (parentNavigationVC, organizeDoItVC) = OrganizeDoItTableViewController.instantiateFromStoryboard()
        organizeDoItVC.settings = organizationManager.organizationSettings
        organizeDoItVC.delegate = self
        present(parentNavigationVC!, animated: true)
    }

    @IBAction func composeButtonPressed() {
        let (parentNavigationVC, createDoItVC) = CreateDoItTableViewController.instantiateFromStoryboard()
        createDoItVC.delegate = self
        createDoItVC.inputMode = .addNewDoIt
        present(parentNavigationVC!, animated: true)
    }
}

// MARK: - Navigation
extension DoItTableViewController: CreateDoItTableViewControllerDelegate {
    func createDoItViewController(_ viewController: CreateDoItTableViewController, didSaveDoIt doIt: DoIt) {
        persistenceManager.save(doIt)
        reorganizeDoIts()
    }

    func createDoItViewController(_ viewController: CreateDoItTableViewController, didEditDoIt doIt: DoIt) {
        persistenceManager.deleteDoIt(matching: doIt.identifier)
        persistenceManager.save(doIt)
        reorganizeDoIts()
    }
}

extension DoItTableViewController: DoItSharingObserver {
    func sharingManager(_ sharingManager: DoItSharingManager, didReceiveDoIts receivedDoIts: [DoIt]) {
        receivedDoIts.forEach(persistenceManager.save)
        addNewRecievedCourses(recievedDoIts: receivedDoIts)
        reorganizeDoIts()
    }

    func addNewRecievedCourses(recievedDoIts: [DoIt]) {
        for doIt in recievedDoIts {
            if !coursePersistenceManager.courses.contains(doIt.course) {
                coursePersistenceManager.save(doIt.course)
            }
        }
    }
}

extension DoItTableViewController: OrganizeDoItTableViewControllerDelegate {
    func organizeDoItViewController(_ viewController: OrganizeDoItTableViewController,
                                    didOrganize settings: DoItOrganizationSettings) {
        organizationManager.organizationSettings = settings
        UserDefaults.standard.organizationSettings = settings
        reorganizeDoIts()
    }
}
