//
//  AlarmTableViewCell.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 29/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

typealias TapClosure = () -> Void

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var switchAlarm: UISwitch?
    
    var tapBlock: TapClosure?
    
    @IBAction func didSwitchAlarm(_ sender: Any) {
        if let tapBlock = self.tapBlock {
            tapBlock()
        }
    }
    
    func configure(withModel model: AlarmTableViewCellModel) {
        timeLabel?.text = model.time
        switchAlarm?.isOn = model.isAlarmActive
    }
}
