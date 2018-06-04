//
//  NCNotificationsTableViewController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

enum Sections {
    case recent
    case yesterday
    case missed
    
    var display: String? {
        switch self {
        case .recent:
            return "Récent"
        case .yesterday:
            return "Hier"
        case .missed:
            return "Manqué"
        }
    }
}

class TestObject: NSObject {
    
    enum AppType {
        case weather
        case message
    }
    
    var appType: AppType!
    var timeCategory: Sections!
    
    init(appType: AppType, timeCategory: Sections) {
        self.appType = appType
        self.timeCategory = timeCategory
    }
    
}

class NCNotificationsTableViewController: UITableViewController {
    
    // TODO: LOCALIZE
    fileprivate var allWidgetDatas = [TestObject]()
    fileprivate var previousWidgetData: TestObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TEST
        allWidgetDatas.append(TestObject(appType: .weather, timeCategory: .recent))
        allWidgetDatas.append(TestObject(appType: .message, timeCategory: .recent))
        allWidgetDatas.append(TestObject(appType: .message, timeCategory: .yesterday))
        allWidgetDatas.append(TestObject(appType: .weather, timeCategory: .missed))
        allWidgetDatas.append(TestObject(appType: .weather, timeCategory: .missed))
        
        
        WidgetSimpleTextViewCell.registerNibFor(tableView: tableView)
        WidgetWeatherViewCell.registerNibFor(tableView: tableView)
    }
}

extension NCNotificationsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WidgetSimpleTextViewCell.cellForTableView(tableView: tableView, indexPath: indexPath) as! WidgetSimpleTextViewCell
        
        let widgetData = self.allWidgetDatas[indexPath.section]
        
        if widgetData.appType == .weather {
            let cell = WidgetWeatherViewCell.cellForTableView(tableView: tableView, indexPath: indexPath) as! WidgetWeatherViewCell
            cell.onCommitPlusAction = {
                tableView.reloadData()
            }
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: SECTIONS
extension NCNotificationsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allWidgetDatas.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let widgetData = self.allWidgetDatas[section]
        
        let view = UIView()
        if section == 0 || self.allWidgetDatas[section - 1].timeCategory != widgetData.timeCategory {
            
            view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 40)
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 26)
            label.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 26)
            label.textColor = .white
            label.text = widgetData.timeCategory.display
            view.addSubview(label)
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            
            let button = UIButton()
            button.addTarget(self, action: #selector(NCNotificationsTableViewController.touchRemoveNotifHeader(_:)), for: .touchUpInside)
            button.setTitle("X", for: .normal)
            button.tag = widgetData.timeCategory.hashValue
            button.frame = CGRect(x: view.frame.width - 35, y: 13.5, width: 25, height: 25)
            button.backgroundColor = UIColor(white: 1, alpha: 0.5)
            button.cornerRadius(button.frame.height / 2)
            button.setTitleColor(.black, for: .normal)
            view.addSubview(button)
        }
        else {
            view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 10)
        }
        
        return view
    }
    
    @objc func touchRemoveNotifHeader(_ sender: UIButton) {
        if sender.tag == 0 { // RECENT
            self.allWidgetDatas = allWidgetDatas.filter({return $0.timeCategory != .recent})
        } else if sender.tag == 1 { // YESTERDAY
            self.allWidgetDatas = allWidgetDatas.filter({return $0.timeCategory != .yesterday})
        } else {
            self.allWidgetDatas = allWidgetDatas.filter({return $0.timeCategory != .missed})
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 50 }
        return (self.allWidgetDatas[section - 1].timeCategory != self.allWidgetDatas[section].timeCategory) ? 50 : 10
    }
}

//MARK: Slide TableView
extension NCNotificationsTableViewController {
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let erase = UITableViewRowAction(style: .normal, title: "Effacer") { (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
        }
        
        let answer = UITableViewRowAction(style: .normal, title: "Répondre") { (action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
        }
        
        erase.backgroundColor = UIColor.lightGray
        answer.backgroundColor = UIColor.lightGray
        
        return [erase, answer]
    }
}
