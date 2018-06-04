//
//  NCPageViewController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class NCPageViewController: UIPageViewController {
    
    var pageControl: UIPageControl!
    
    lazy var ncNotificationsVC: NCNotificationsTableViewController = {
        return self.storyboard?.instantiateViewController(withIdentifier: "NCNotificationsTableViewController") as! NCNotificationsTableViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        self.setViewControllers([ncNotificationsVC], direction: .forward, animated: false, completion: nil)
    }
}

extension NCPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
}
