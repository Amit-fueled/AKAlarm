//
//  AlarmTableViewCellModel.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 02/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

struct AlarmTableViewCellModel {
    
    let date: String
    let time: String
    var isAlarmActive: Bool
    
    init(object: Alarm){
        date = object.date
        time = object.time
        isAlarmActive = object.isAlarmActive
    }
    
    mutating func revertAlarm(){
        isAlarmActive = !(isAlarmActive)
    }
}
