//
//  UIColor+Extension.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 01/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }
    
    // Usage: UIColor(hex: 0xFC0ACE, alpha: 0.25)
    public convenience init(hex: Int, alpha: Double) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255,
            alpha: CGFloat(alpha))
    }
    
    public convenience init(hexa: String, alpha: Double) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        var index = hexa.index(hexa.startIndex, offsetBy: 0)
        if hexa.hasPrefix("#") {
            index = hexa.index(hexa.startIndex, offsetBy: 1)
        }
        
        let hex = hexa.substring(from: index)
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            if hex.characters.count == 6 {
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
                
                self.init(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
            }else{
                self.init(red:0, green:0, blue:0, alpha:0)
            }
        }else{
            self.init(red:0, green:0, blue:0, alpha:0)
        }
        
    }
    
    public convenience init(hexa: String) {
        self.init(hexa: hexa, alpha: 1)
    }
}
