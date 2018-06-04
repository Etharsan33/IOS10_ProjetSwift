//
//  String+Extension.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 27/04/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

extension String {
    
    var localized : String {
        
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let localizableFile = "Localizable"
        let undefinedValue = appName + localizableFile + ":[Undefined String : " + self + "]"
        var val = Bundle.main.localizedString(forKey: self, value: undefinedValue, table: localizableFile)
        if val == undefinedValue {
            let bundle = Bundle(for: HomeScreenViewController.self)
            val = bundle.localizedString(forKey: self, value: nil, table: localizableFile)
        }
        
        return val
    }
}
