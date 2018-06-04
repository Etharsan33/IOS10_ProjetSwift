//
//  ControlCenterMusicView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class ControlCenterMusicView: BaseView {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerRadius(12)
        albumImageView.cornerRadius(10)
    }
}
