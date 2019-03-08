//
//  AlertDateTableTableViewController.swift
//  Do-It
//
//  Created by Cesar F. Chacon on 3/5/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit
import Do_ItCore

protocol AlertDateTableViewControllerDelegate: AnyObject {
    func alertDateTableViewController(_ alertVC: AlertDateTableViewController,
                                      didSelectDate alertWhen: DateComponents, alertString: String)
}

class AlertDateTableViewController: UITableViewController {
    let alertOptions = ["1 day", "3 days", "1 week", "2 weeks", "1 month"]
     weak var delegate: AlertDateTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertOption", for: indexPath)
        cell.textLabel?.text = alertOptions[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = alertOptions[indexPath.row]
        var dateComponent = DateComponents()
        switch option {
        case "1 day":
            dateComponent.day = -1
        case "3 days":
            dateComponent.day = -3
        case "1 week":
            dateComponent.day = -7
        case "2 weeks":
            dateComponent.day = -14
        case "1 month" :
            dateComponent.month = -1
        default:
            print("Not an option")
        }
        delegate?.alertDateTableViewController(self, didSelectDate: dateComponent, alertString: option)
        navigationController?.popViewController(animated: true)
    }
}
