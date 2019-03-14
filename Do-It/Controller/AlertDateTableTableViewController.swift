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
                                      didSelectDate alertWhen: (DateComponents, String)?)
}

class AlertDateTableViewController: UITableViewController {
    var options: [Option] = []

    struct Option {
        let name: String
        let alertOption: DateComponents

        init(description: String, option: DateComponents) {
            name = description
            alertOption = option
        }
    }

    func makeTimeOptions() {
        var seconds = DateComponents()
        seconds.second = -100

        var oneDay = DateComponents()
        oneDay.day = -1

        var threeDays = DateComponents()
        threeDays.day = -3

        var oneWeek = DateComponents()
        oneWeek.day = -7

        var twoWeeks = DateComponents()
        twoWeeks.day = -14

        var oneMonth = DateComponents()
        oneMonth.month = -1

        options.append(Option(description: "100 seconds", option: seconds))
        options.append(Option(description: "1 day", option: oneDay))
        options.append(Option(description: "3 days", option: threeDays))
        options.append(Option(description: "1 week", option: oneWeek))
        options.append(Option(description: "2 weeks", option: twoWeeks))
        options.append(Option(description: "1 month", option: oneMonth))
    }

     weak var delegate: AlertDateTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTimeOptions()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertOption", for: indexPath)
        cell.textLabel?.text = options[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.alertDateTableViewController(self,
            didSelectDate: (options[indexPath.row].alertOption,
                            options[indexPath.row].name))
        navigationController?.popViewController(animated: true)
    }
}
