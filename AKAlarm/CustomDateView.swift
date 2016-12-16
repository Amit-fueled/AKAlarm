//
//  CustomDateView.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 30/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//
import UIKit

protocol CustomDateViewDelegate: class{
    func didTapCancel()
    func didTapDone(_ selectedDate: Date)
}

class CustomDateView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.datePickerMode = .time
            datePicker.timeZone = TimeZone(identifier: "Asia/Kolkata")
            let currentDate = Date()
            datePicker.date = currentDate
        }
    }
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: CustomDateViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.didTapCancel()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        var selectedDate = datePicker.date
        
        if selectedDate < Date() {
            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        }
        delegate?.didTapDone(selectedDate)
    }
}
