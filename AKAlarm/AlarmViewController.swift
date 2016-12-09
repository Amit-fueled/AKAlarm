//
//  ViewController.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 29/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,DismissibleDatePicker,AlarmListViewModelDelegate {
    
    @IBOutlet weak var tableViewAlarm: UITableView!
    @IBOutlet weak var heightOfCustomDateView: NSLayoutConstraint!
    
    @IBOutlet weak var customDateView: CustomDateView! {
        didSet{
            customDateView?.delegate = self
        }
    }
    var viewModel: AlarmViewControllerViewModel? {
        didSet{
            viewModel?.delegate = self
        }
    }
    
    static let rowHeight = 51
    static let numberOfSection = 1
    static let heightForHeaderInSection = 0
    static let cellNibName = "AlarmTableViewCell"
    static let navigationTitle = "Create Alarm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AlarmViewController.addTapped))
        navigationItem.title = AlarmViewController.navigationTitle
        tableViewAlarm.register(UINib(nibName: AlarmViewController.cellNibName, bundle: nil), forCellReuseIdentifier: AlarmViewController.cellNibName)
        tableViewAlarm.tableFooterView = UIView()
        tableViewAlarm.allowsSelection = false
        
        heightOfCustomDateView.constant = 0
        viewModel = AlarmViewControllerViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped(sender: Any){
        
        customDateView.datePicker.date = Date()
        UIView.animate(withDuration: 0.5, animations: {
            self.heightOfCustomDateView.constant = 150
            self.view.layoutIfNeeded()
            
        })
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(AlarmViewController.heightForHeaderInSection)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return AlarmViewController.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.cellDataArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewAlarm.dequeueReusableCell(type: AlarmTableViewCell.self, forIndexPath: indexPath)
        
        if let cellModel = viewModel?.cellData(at: indexPath.row)
        {
            cell?.configure(withModel: cellModel)
        }
        cell?.tapBlock = {
            self.viewModel?.didSwitchAlarm(at: indexPath.row)
            self.tableViewAlarm.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(AlarmViewController.rowHeight)
    }
    
    // MARK: Cancel and done button actions
    func didTapDone(_ selectedDate: Date) {
        
        guard let result = (viewModel?.setAnAlarm(on: selectedDate)) else {
            return
        }
        
        if result{
            UIView.animate(withDuration: 0.5, animations: {
                self.heightOfCustomDateView.constant = 0 // heightCon is the IBOutlet to the constraint
                self.view.layoutIfNeeded()
            })
        }else{
            let alertView = UIAlertController(title: "Message",
                                              message: "Try for an another time.", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func didTapCancel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightOfCustomDateView.constant = 0 // heightCon is the IBOutlet to the constraint
            self.view.layoutIfNeeded()
        })
    }
    
    func reloadViews() {
        
        DispatchQueue.main.async {
            self.tableViewAlarm.reloadData()
        }
    }
}
extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self as Date)
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self as Date)
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension UITableView {
    
    func dequeueReusableCell<T:UITableViewCell>(type: T.Type) -> T? {
        var fullName: String = NSStringFromClass(T.self)
        if let range = fullName.range(of: ".", options: .backwards, range: nil, locale: nil) {
            fullName = fullName.substring(from: range.upperBound)
        }
        return self.dequeueReusableCell(withIdentifier: fullName) as? T
    }
    
    func dequeueReusableCell<T:UITableViewCell>(type: T.Type, forIndexPath indexPath:IndexPath) -> T? {
        var fullName: String = NSStringFromClass(T.self)
        if let range = fullName.range(of: ".", options: .backwards, range: nil, locale: nil) {
            fullName = fullName.substring(from: range.upperBound)
        }
        return self.dequeueReusableCell(withIdentifier: fullName, for:indexPath) as? T
    }
}
