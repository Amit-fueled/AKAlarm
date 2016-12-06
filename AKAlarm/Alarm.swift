//
//  Alarm.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 03/12/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    
    let date: String!
    let time: String!
    let isAlarmActive: Bool!
    
    init(dict: [String: Any]) {
        date = dict["date"] as! String
        time = dict["time"] as! String
        isAlarmActive = dict["isAlarmActive"] as! Bool
    }

}
