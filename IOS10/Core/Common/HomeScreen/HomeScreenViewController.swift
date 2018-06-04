//
//  HomeScreenViewController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 27/04/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import Hero

class HomeScreenViewController: BaseViewController {
    
    @IBOutlet weak var globalstackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImgBackWithBlackOpacity()
        
        // Get Event Touch for AppIconView
        for subview in globalstackView.subviews where subview is UIStackView {
            for _subview in subview.subviews where _subview is AppIconView {
                (_subview as! AppIconView).onCommitClick = { [weak self] type, iconButton in
                    self?.tapIconAction(type, iconButton)
                }
            }
        }
        
        //ADD NOTIFICATION CENTER
        let notificationCenter = UIStoryboard(name: "NotificationCenter", bundle: nil).instantiateViewController(withIdentifier: "NotificationCenterViewController") as! NotificationCenterViewController
        self.addChildViewController(notificationCenter)
        notificationCenter.view.frame = CGRect(x: 0, y: -self.view.frame.size.height, width: view.frame.size.width, height: view.frame.size.height)
        self.view.addSubview(notificationCenter.view)
        notificationCenter.didMove(toParentViewController: self)
    }
    
    private func createImgBackWithBlackOpacity() {
        let frameView = CGRect(x:0, y:0, width:view.frame.width, height:view.frame.height)
        let img_view = UIImageView(image: #imageLiteral(resourceName: "wallpaper"))
        img_view.frame = frameView
        img_view.contentMode = .scaleToFill
        
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tintView.frame = CGRect(x: 0, y: 0, width: img_view.frame.width, height: img_view.frame.height)
        
        img_view.addSubview(tintView)
        
        view.insertSubview(img_view, at: 0)
    }
    
    func tapIconAction(_ appIconType: AppIconView.Types, _ iconButton: UIButton) {
    
        let vc = MultiTaskHandler.shared.redirection(appIconType, self.storyboard!.instantiateViewController(withIdentifier: "TestViewController") as! BaseViewController)
        
        vc.hero.isEnabled = true
        
        vc.view.backgroundColor = .green
        vc.view.hero.id = iconButton.hero.id
        
        present(vc, animated: true, completion: nil)
    }
}
