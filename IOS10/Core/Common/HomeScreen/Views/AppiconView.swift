//
//  AppIconView.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 27/04/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

@IBDesignable
class AppIconView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: ENUM
    public enum Types: Int {
        case appStore
        case calendar
        case clock
        case camera
        case facetime
        case health // 5
        case iBooks
        case iTunes
        case mail
        case maps
        case messages // 10
        case music
        case news
        case notes
        case photos
        case reminders // 15
        case safari
        case settings
        case stocks
        case videos
        case wallet // 20
        case weather
        case phone
        case unknown
        
        var display: String? {
            switch self {
            case .appStore:
                return "APPSTORE".localized
            case .calendar:
                return "CALENDAR".localized
            case .clock:
                return "CLOCK".localized
            case .camera:
                return "CAMERA".localized
            case .facetime:
                return "FACETIME".localized
            case .health:
                return "HEALTH".localized
            case .iBooks:
                return "IBOOKS".localized
            case .iTunes:
                return "ITUNES".localized
            case .mail:
                return "MAIL".localized
            case .maps:
                return "MAPS".localized
            case .messages:
                return "MESSAGES".localized
            case .music:
                return "MUSIC".localized
            case .news:
                return "NEWS".localized
            case .notes:
                return "NOTES".localized
            case .photos:
                return "PHOTOS".localized
            case .reminders:
                return "REMINDERS".localized
            case .safari:
                return "SAFARI".localized
            case .settings:
                return "SETTINGS".localized
            case .stocks:
                return "STOCKS".localized
            case .videos:
                return "VIDEOS".localized
            case .wallet:
                return "WALLET".localized
            case .weather:
                return "WEATHER".localized
            case .phone:
                return "PHONE".localized
            case .unknown:
                return "Unknown"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .appStore:
                return #imageLiteral(resourceName: "appStore")
            case .calendar:
                return #imageLiteral(resourceName: "calendar")
            case .clock:
                return #imageLiteral(resourceName: "clock")
            case .camera:
                return #imageLiteral(resourceName: "camera_icon")
            case .facetime:
                return #imageLiteral(resourceName: "Facetime")
            case .health:
                return #imageLiteral(resourceName: "health")
            case .iBooks:
                return #imageLiteral(resourceName: "iBooks")
            case .iTunes:
                return #imageLiteral(resourceName: "itunes")
            case .mail:
                return #imageLiteral(resourceName: "mail")
            case .maps:
                return #imageLiteral(resourceName: "maps")
            case .messages:
                return #imageLiteral(resourceName: "messages")
            case .music:
                return #imageLiteral(resourceName: "music")
            case .news:
                return #imageLiteral(resourceName: "news")
            case .notes:
                return #imageLiteral(resourceName: "notes")
            case .photos:
                return #imageLiteral(resourceName: "photos")
            case .reminders:
                return #imageLiteral(resourceName: "reminders")
            case .safari:
                return #imageLiteral(resourceName: "safari")
            case .settings:
                return #imageLiteral(resourceName: "settings")
            case .stocks:
                return #imageLiteral(resourceName: "stocks")
            case .videos:
                return #imageLiteral(resourceName: "videos")
            case .wallet:
                return #imageLiteral(resourceName: "wallet")
            case .weather:
                return #imageLiteral(resourceName: "weather")
            case .phone:
                return #imageLiteral(resourceName: "phone")
            case .unknown:
                return #imageLiteral(resourceName: "defaultIcon")
            }
        }
    }
    
    @IBInspectable
    public var appIconType: Int = 0 {
        didSet {
            self.appType = Types(rawValue: appIconType)!
        }
    }
    
    private var appType: Types = .unknown
    var onCommitClick: ((Types, UIButton) -> Void)?

    //MARK: INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        xibSetup()
    }
    //****//
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.iconButton?.hero.id = appType.display
        self.iconButton?.setImage(appType.icon, for: .normal)
        self.nameLabel?.text = appType.display
    }
    
    //MARK: FOR SETUP XIB
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AppIconView", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    /*override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }*/
    //****//
    
    //MARK: ACTIONS
    @IBAction func tapIcon(_ sender: UIButton) {
        onCommitClick?(self.appType, sender)
    }
    
}
