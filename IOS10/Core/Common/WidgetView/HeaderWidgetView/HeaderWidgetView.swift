//
//  HeaderWidgetView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class HeaderWidgetView: BaseView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView?.cornerRadius(6)
    }
}
