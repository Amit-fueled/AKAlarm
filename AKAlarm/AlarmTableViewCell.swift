//
//  AlarmTableViewCell.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 29/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

typealias TapClosure = () -> ()

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var switchAlarm: UISwitch!

    var tapBlock: TapClosure?
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func didSwitchAlarm(_ sender: Any) {
        if let tapBlock = self.tapBlock {
            tapBlock()
        }
    }
    
    func configure(withModel model: AlarmTableViewCellModel) {
        
        timeLabel.text = model.time
        switchAlarm.isOn = model.isAlarmActive
    }

}
