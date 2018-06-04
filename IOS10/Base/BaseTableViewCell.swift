//
//  BaseTableViewCell.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation
import UIKit

open class BaseTableViewCell : UITableViewCell {
    
    //MARK: Instance
    class public func registerNibFor(tableView: UITableView) {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: String(describing: self))
    }
    
    class open func cellForTableView(tableView: UITableView, indexPath : IndexPath) -> BaseTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as! BaseTableViewCell
    }
    
}
