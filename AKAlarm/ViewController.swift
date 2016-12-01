//
//  ViewController.swift
//  AKAlarm
//
//  Created by Amit-Fueled on 29/11/16.
//  Copyright © 2016 Amit-Fueled. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,DismissibleDatePicker {

    @IBOutlet weak var tableViewAlarm: UITableView!
    @IBOutlet weak var heightOfCustomDateView: NSLayoutConstraint!
    
    var customDateView: CustomDateView? {
        didSet{
            customDateView?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addTapped))
        navigationItem.title = "Create Alarm"
        tableViewAlarm.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "AlarmTableViewCell")
        tableViewAlarm.tableFooterView = UIView()
        tableViewAlarm.allowsSelection = false
        
        customDateView = CustomDateView()
        heightOfCustomDateView.constant = 0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTapped(sender: Any){
        
        heightOfCustomDateView.constant = 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewAlarm.dequeueReusableCell(type: AlarmTableViewCell.self, forIndexPath: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 51
    }
    
    // MARK: Cancel and done button actions
    
    func didTapDone() {
     
        heightOfCustomDateView.constant = 0
        
    }
    
    func didTapCancel() {
        heightOfCustomDateView.constant = 0
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
