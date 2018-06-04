//
//  ControlCenter.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class ControlCenter: BaseView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let padding: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        for index in 0..<2 {
            
            //frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            
            let con = (index == 0) ? ControlCenterSettingsView.instance : ControlCenterMusicView.instance
            con.frame = frame.insetBy(dx: padding, dy: 0)
            self.scrollView.addSubview(con)
        }
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 2, height: self.scrollView.frame.size.height)
        //self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 2, height: self.scrollView.frame.size.height)
        
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: .valueChanged)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
    }
    
    //MARK: CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
}

// MARK: UIScrollViewDelegate
extension ControlCenter: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
