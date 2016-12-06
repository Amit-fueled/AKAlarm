//
//  AlarmViewControllerViewModel.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 03/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

protocol AlarmListViewModelDelegate : class{
    
    func reloadViews()
}

protocol AlarmsDataFetcher {
    
    var cellDataArray: [AlarmTableViewCellModel] { get set }
    weak var delegate : AlarmListViewModelDelegate? { get set }
    func reloadData()
}

class AlarmViewControllerViewModel: AlarmsDataFetcher {
    
    var cellDataArray: [AlarmTableViewCellModel] = []
    weak var delegate : AlarmListViewModelDelegate?

    func reloadData() {
        
        
    }
    
    func prepareCellData(with selectedDate: Date){
        
        
    }
    
    func setAnAlarm(with selectedDate: Date){
        
        var alarmDict = [String:Any]()
        let selectedDateString = selectedDate.toString()
        print(selectedDateString)
        alarmDict["date"] = selectedDate.getDate()
        alarmDict["time"] = selectedDate.getTime()
        alarmDict["isAlarmActive"] = true
        let alarmObject = Alarm(dict: alarmDict)
        let cellModel = AlarmTableViewCellModel(object: alarmObject)
        cellDataArray.append(cellModel)
        delegate?.reloadViews()
        
        let notification = UNMutableNotificationContent()
        notification.title = "Alarm"
        notification.body = "Wake up"
        notification.sound = UNNotificationSound.default()
        // assign a unique identifier to the notification so that we can retrieve it later
        notification.userInfo = ["UUID": selectedDate.getTime()]
        notification.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: selectedDate.timeIntervalSince(Date()), repeats: false)
        let request = UNNotificationRequest.init(identifier: selectedDate.getTime(), content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error?.localizedDescription ?? "Notification could not be added")
            }
        })
        
    }
    
    func cellData(at index: Int) -> AlarmTableViewCellModel? {
        
        if cellDataArray.count > index {
            return cellDataArray[index]
        }
        return nil
    }
    
    func didSwitchAlarm(at index: Int) -> () {
        
        if cellDataArray.count > index{
            cellDataArray[index].revertAlarm()
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(cellData(at: index)?.time)!])
        }
    }

    
}
