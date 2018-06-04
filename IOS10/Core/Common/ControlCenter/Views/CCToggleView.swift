//
//  CCToggleView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class CCToggleView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var onCommitClick: ((Bool, Toggle) -> Void)?
    
    //MARK: ENUM
    public enum Toggle: Int {
        case airplane
        case wifi
        case bluetooth
        case notDistrub
        case orientationLock
        
        var color: UIColor {
            switch self {
            case .airplane:
                return UIColor.init(hexa: "#ff9500")
            case .wifi:
                return UIColor.init(hexa: "#007aff")
            case .bluetooth:
                return UIColor.init(hexa: "#007aff")
            case .notDistrub:
                return UIColor.init(hexa: "#5856d6")
            case .orientationLock:
                return UIColor.init(hexa: "#ff4d30")
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .airplane:
                return #imageLiteral(resourceName: "airplane")
            case .wifi:
                return #imageLiteral(resourceName: "wifi")
            case .bluetooth:
                return #imageLiteral(resourceName: "bluetooth")
            case .notDistrub:
                return #imageLiteral(resourceName: "not_disturb")
            case .orientationLock:
                return #imageLiteral(resourceName: "orientation_lock")
            }
        }
        
        //TODO: DO LOCALIZED
        var display: String? {
            switch self {
            case .airplane:
                return "Mode avion"
            case .wifi:
                return "Wi-Fi"
            case .bluetooth:
                return "Bluetooth"
            case .notDistrub:
                return "Ne pas déranger"
            case .orientationLock:
                return "Orientation portrait"
            }
        }
    }
    
    @IBInspectable
    public var toggle: Int = 0 {
        didSet {
            imageView?.image = Toggle(rawValue: toggle)?.icon
            imageView?.image = imageView?.image!.withRenderingMode(.alwaysTemplate) // For change Tint in image
        }
    }
    
    private var isSelected: Bool = false {
        didSet {
            imageView.tintColor = (isSelected) ? .white : .black
            backgroundColor = (isSelected) ? Toggle(rawValue: toggle)?.color : UIColor(white: 0, alpha: 0.1)
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
        let nib = UINib(nibName: String(describing: CCToggleView.self), bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(white: 0, alpha: 0.1)
        cornerRadius(frame.height / 2)
    }
    
    // MARK: ACTIONS
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.isSelected = !self.isSelected
        onCommitClick?(isSelected, Toggle(rawValue: toggle)!)
    }
}
