//
//  CustomDateView.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 30/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

protocol DismissibleDatePicker: class{
    
    func didTapCancel()
    func didTapDone()
}

class CustomDateView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: DismissibleDatePicker?
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        delegate?.didTapCancel()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        delegate?.didTapDone()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
