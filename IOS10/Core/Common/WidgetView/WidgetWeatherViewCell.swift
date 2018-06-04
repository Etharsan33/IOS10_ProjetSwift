//
//  WidgetWeatherViewCell.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class WidgetWeatherViewCell: WidgetViewCell {
    
    @IBOutlet weak var plusView: UIView!
    
    var isPlusViewhidden = true
    var onCommitPlusAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.plusView?.isHidden = self.isPlusViewhidden
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        self.isPlusViewhidden = !isPlusViewhidden
        self.plusView.isHidden = self.isPlusViewhidden
        onCommitPlusAction?()
    }
    
}
