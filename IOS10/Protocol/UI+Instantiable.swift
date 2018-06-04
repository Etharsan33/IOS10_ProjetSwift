//
//  UI+Instantiable.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import Foundation
import UIKit


protocol InstantiableView : class {
    static var instance : UIView {get}
    func xibSetup(_ nibName: String)
}

extension InstantiableView where Self : UIView {
    
    static var instance : UIView {
        let bundle = Bundle(for: Self.self)
        return bundle.loadNibNamed(String(describing: self), owner: self, options: nil)!.first as! UIView
    }
    
    func xibSetup(_ nibName: String) {
        
        let bundle = Bundle(for: type(of: self))
        
        func loadNibNamed<T>(_ name: String, owner: Any?, bundle : Bundle, options: [AnyHashable : Any]? = nil) -> T where T : UIView {
            return bundle.loadNibNamed(name, owner: owner, options: options)!.first as! T
        }
        
        let view = loadNibNamed(nibName, owner: self, bundle: bundle, options: nil)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
