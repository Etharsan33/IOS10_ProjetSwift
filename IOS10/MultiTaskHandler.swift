//
//  MultiTaskHandler.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 11/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class MultiTaskHandler {
    
    static let shared = MultiTaskHandler()
    
    var viewControllers: [AppIconView.Types : BaseViewController]!
    
    init() {
        self.viewControllers = [AppIconView.Types : BaseViewController]()
    }
    
    // MARK: ADD AND REMOVE IN STACK
    private func addInStack(_ app: AppIconView.Types, _ viewController: BaseViewController) {
        self.viewControllers[app] = viewController
    }
    
    func removeInStack(_ app: AppIconView.Types) {
        self.viewControllers.removeValue(forKey: app)
    }
    
    private func isInStack(_ app: AppIconView.Types) -> BaseViewController? {
        for (k, v) in self.viewControllers {
            if k == app {
                return v
            }
        }
        return nil
    }
    
    // MARK: Redirection
    func redirection(_ app: AppIconView.Types, _ viewController: BaseViewController) -> BaseViewController {
        if let VC = isInStack(app) {
            return VC
        } else {
            addInStack(app, viewController)
        }
        
        return viewController
    }
    
}
