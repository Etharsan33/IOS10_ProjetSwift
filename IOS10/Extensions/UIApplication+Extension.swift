//
//  UIApplication+Extension.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 13/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

// SAVOIR SUR QUELLE PAGE ON EST
extension UIApplication {
    class func currentViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return currentViewController(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return currentViewController(controller: presented)
        }
        return controller
    }
}
