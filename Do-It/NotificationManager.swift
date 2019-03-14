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

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, error) in
            if let error = error {
                print("Notification authorization request error: \(error)")
            }
        }
    }

    func setTrigger(_ doIt: DoIt, _ alertOption: DateComponents?) {
        if alertOption != nil {
            let alertWhen = Calendar.current.date(byAdding: alertOption!, to: doIt.dueDate)
            let deltaTime = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day,
                    .hour, .minute, .second], from: alertWhen!, to: doIt.dueDate)
            let formatter = DateComponentsFormatter()
            let content = UNMutableNotificationContent()
            content.title = "Do-It Due Soon"
            content.body = "Be sure to complete " + doIt.name + " within " + formatter.string(from: deltaTime)!
            let dateComponents = Calendar.current.dateComponents([.year, .month, .weekOfMonth, .day,
                    .hour, .minute, .second], from: alertWhen!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: doIt.identifier.identifier.uuidString,
                    content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }

    func cancelNotification(_ doIt: DoIt) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [doIt.identifier.identifier.uuidString])
    }

    func reschedule(_ doIt: DoIt, _ newDueDate: DateComponents?) {
        cancelNotification(doIt)
        setTrigger(doIt, newDueDate)
    }
}
