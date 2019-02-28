//
//  NotificationManager.swift
//  Do-ItCore
//
//  Created by Cesar F. Chacon on 2/27/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UserNotifications

class NotificationManager {
    let center = UNUserNotificationCenter.current()

    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
                // do something if granted is false, user did not allow notifications
        }
    }

    func setTrigger(_ doIt: DoIt) {
        let content = UNMutableNotificationContent()
        content.title = "Your DoIt is due " + doIt.dueDate.description
        content.body = "Go finish it"
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: doIt.dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: doIt.identifier.identifier.uuidString, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: {
            (error) in
                // check error param
        })
    }
}
