//
//  CCShorcutsView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class CCShorcutsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: ENUM
    public enum Shorcuts: Int {
        case flashLight
        case compass
        case calculator
        case camera
        
        var icon: UIImage? {
            switch self {
            case .flashLight:
                return #imageLiteral(resourceName: "flashlight")
            case .compass:
                return #imageLiteral(resourceName: "timer")
            case .calculator:
                return #imageLiteral(resourceName: "calculator")
            case .camera:
                return #imageLiteral(resourceName: "CCcamera")
            }
        }
    }
    
    @IBInspectable
    public var shorcut: Int = 0 {
        didSet {
            imageView?.image = Shorcuts(rawValue: shorcut)?.icon
        }
    }
    
    private var isSelected: Bool = false {
        didSet {
            backgroundColor = (isSelected) ? .white : UIColor(white: 0, alpha: 0.1)
        }
    }
    
    // MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchAction))
        self.addGestureRecognizer(gesture)
        xibSetup()
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: CCShorcutsView.self), bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(white: 0, alpha: 0.1)
        cornerRadius(10)
    }
    
    // MARK: ACTIONS
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.isSelected = !self.isSelected
    }
}

