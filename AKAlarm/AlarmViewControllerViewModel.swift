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
    let alarmHandler: AlarmHandler
    
    init(){
        alarmHandler = AlarmHandler()
    }
    
    func reloadData() {
        
    }
    
    func prepareCellData(with selectedDate: Date){
        
    }
    
    func setAnAlarm(on selectedDate: Date) -> Bool? {
        
        for cellData in cellDataArray {
            if cellData.time == selectedDate.getTime() {
                return false
            }
        }
        if selectedDate.minutes(from: Date()) < 1 {
            return false
        }
        var alarmDict = [String:Any]()
        let selectedDateString = selectedDate.toString()
        print(selectedDateString)
        alarmDict["date"] = selectedDateString
        alarmDict["time"] = selectedDate.getTime()
        alarmDict["isAlarmActive"] = true
        let alarmObject = Alarm(dict: alarmDict)
        let cellModel = AlarmTableViewCellModel(object: alarmObject)
        cellDataArray.append(cellModel)
        alarmHandler.scheduleNotification(on: selectedDate)
        delegate?.reloadViews()
        return true
    }
    
    func cellData(at index: Int) -> AlarmTableViewCellModel? {
        
        if cellDataArray.count > index {
            return cellDataArray[index]
        }
        return nil
    }
    
    func didSwitchAlarm(at index: Int) -> () {
        
        guard cellData(at: index)?.time != nil else {
            return
        }
        cellDataArray[index].revertAlarm()
        alarmHandler.cancelNotification(with: [(cellData(at: index)?.time)!])
        
    }
    
    func updateAlarmsStates(){
        
        cellDataArray = cellDataArray.filter { $0.date < Date().toString() }.map {
            var newObject = $0
            newObject.isAlarmActive = false
            return newObject
        }
        delegate?.reloadViews()
    }
}
