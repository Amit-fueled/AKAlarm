//
//  AlarmHandler.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 06/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class AlarmHandler {
        
    func scheduleNotification(on selectedDate: Date){
        
        let notification = UNMutableNotificationContent()
        notification.title = "Alarm"
        notification.body = "Wake up"
        notification.sound = UNNotificationSound.default()
        notification.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: selectedDate.timeIntervalSince(Date()), repeats: false)
        let request = UNNotificationRequest.init(identifier: selectedDate.getTime(), content: notification, trigger: trigger)
        
        // assign a unique identifier to the notification so that we can retrieve it later

        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error?.localizedDescription ?? "Notification could not be added")
            }
        })
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func cancelNotification(with identifires: [String]){
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifires)
    }
    
}
