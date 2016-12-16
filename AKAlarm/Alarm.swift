//
//  Alarm.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 03/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

final class Alarm {
    
    let date: Date
    let isAlarmActive: Bool
    
    init(dict: [String: Any]) {
        date = dict["date"] as! Date
        isAlarmActive = dict["isAlarmActive"] as! Bool
    }

}
