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
    func didTapDone(_ selectedDate: Date)
}

class CustomDateView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.datePickerMode = .dateAndTime
            datePicker.timeZone = TimeZone(identifier: "Asia/Kolkata")
            let currentDate = Date()
            datePicker.minimumDate = currentDate
            datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
            datePicker.date = currentDate
        }
    }
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: DismissibleDatePicker?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        delegate?.didTapCancel()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        let selectedDate = datePicker.date
        delegate?.didTapDone(selectedDate)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
