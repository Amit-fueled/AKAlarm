//
//  AlarmViewControllerViewModel.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 03/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import Foundation

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
    let alarmHandler = AlarmHandler()
    
    func reloadData() {
        
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
        
        if selectedDate < Date(){
            return false
        }
        
        let alarmObject = Alarm(dict: makeDict(date: selectedDate))
        let cellModel = AlarmTableViewCellModel(object: alarmObject)
        cellDataArray.append(cellModel)
        AlarmHandler.scheduleNotification(for: selectedDate)
        delegate?.reloadViews()
        return true
    }
    
    private func makeDict(date selectedDate: Date) -> [String: Any]{
        var alarmDict = [String:Any]()
        alarmDict["date"] = selectedDate
        alarmDict["isAlarmActive"] = true
        return alarmDict
    }
    
    func cellData(at index: Int) -> AlarmTableViewCellModel? {
        
        if cellDataArray.count > index {
            return cellDataArray[index]
        }
        return nil
    }
    
    func didSwitchAlarm(at index: Int) -> () {
        
        guard let cellModel = cellData(at: index) else {
            return
        }
        
        if cellModel.date > Date().toString() {
           
            cellDataArray[index].revertAlarm()
            AlarmHandler.cancelNotification(for: [cellModel.time])
        }
    }
    
    func updateAlarmsState(){
        
        cellDataArray = cellDataArray.map {
            var newObject = $0
            if newObject.date < Date().toString() {
                newObject.isAlarmActive = false
            }
            return newObject
        }
        delegate?.reloadViews()
    }
}
