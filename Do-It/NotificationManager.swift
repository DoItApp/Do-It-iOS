//
//  NotificationManager.swift
//  Do-ItCore
//
//  Created by Cesar F. Chacon on 2/27/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UserNotifications
import Do_ItCore

class NotificationManager {
    let center = UNUserNotificationCenter.current()

    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print(error as Any)
        }
    }

    func setTrigger(_ doIt: DoIt, _ alertWhen: Date) {
        let deltaTime = Calendar.current.dateComponents([.year, .month, .day,
                .hour, .minute, .second], from: alertWhen, to: doIt.dueDate)
        let formatter = DateComponentsFormatter()
        let content = UNMutableNotificationContent()
        content.title = "Do-It Due Soon"
        content.body = "Be sure to complete " + doIt.name + " within " + formatter.string(from: deltaTime)!
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day,
                .hour, .minute, .second], from: alertWhen)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: doIt.identifier.identifier.uuidString,
                content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            print(error as Any)
        })
    }

    func cancelNotification(_ doIt: DoIt) {
        center.removePendingNotificationRequests(withIdentifiers: [doIt.identifier.identifier.uuidString])
    }

    func reschedule(_ doIt: DoIt, _ newDueDate: Date) {
        cancelNotification(doIt)
        setTrigger(doIt, newDueDate)
    }
}
