//
//  ControlCenterSettingsView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class ControlCenterSettingsView: BaseView {
    
    @IBOutlet weak var toggleLabel: UILabel!
    @IBOutlet weak var stackViewToggle: UIStackView!
    @IBOutlet weak var nightShiftButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cornerRadius(12)
        setupToggle()
        
        // Setup NightShift
        nightShiftButton?.cornerRadius(10)
    }
    
    // MARK: TOGGLE
    private func setupToggle() {
        guard let stackView = stackViewToggle else { return }
        for subview in stackView.subviews where subview is CCToggleView {
            (subview as! CCToggleView).onCommitClick = { [weak self] isSelected, toggle in
                changeToggleLabel(isSelected, toggle)
            }
        }
        
        func changeToggleLabel(_ isSelected: Bool, _ toggle: CCToggleView.Toggle) {
            var onOff = ""
            if (toggle == .orientationLock) {
                onOff = (isSelected) ? " vérouiller" : " dévérouiller"
            } else {
                onOff = (isSelected) ? " : activé" : " : désactivé"
            }
            self.toggleLabel.text = (toggle.display ?? "") + onOff
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                self.toggleLabel.alpha = 1
            }, completion: {
                (finished: Bool) -> Void in
                UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
                    self.toggleLabel.alpha = 0
                }, completion: nil)
            })
        }
    }
}
