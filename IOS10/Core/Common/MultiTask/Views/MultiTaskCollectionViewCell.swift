//
//  MultiTaskCollectionViewCell.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 12/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class MultiTaskCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var appIconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerImageView: UIImageView!
    
    private var initialPositionY: CGFloat?
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    var onCommitKillApp: (() -> ())?
    
    lazy var swipeGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(MultiTaskCollectionViewCell.swipeHandle(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.frame.origin.y = (self.appIconImageView.frame.height + 8)
        appIconImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView?.cornerRadius(8)
        containerView?.addGestureRecognizer(swipeGesture)
        initialPositionY = containerView?.frame.origin.y
    }
    
    @objc func swipeHandle(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: containerView)
        //let velocity = sender.velocity(in: containerView)
        
        if sender.state == .began {
            initialTouchPoint = touchPoint
        } else if sender.state == .changed {
            UIView.animate(withDuration: 0.1, animations: {
                self.containerView.frame.origin.y = touchPoint.y - self.initialTouchPoint.y
            })
        } else if sender.state == .ended || sender.state == .cancelled {
            let condition = touchPoint.y - self.initialTouchPoint.y < -170
            UIView.animate(withDuration: 0.3, animations: {
                if condition {
                    self.containerView.frame.origin.y = -self.containerView.frame.height
                    return
                }
                self.containerView.frame.origin.y = self.initialPositionY ?? (self.appIconImageView.frame.height + 8)
            }, completion: { (completed) in
                if condition { self.onCommitKillApp?() }
            })
        }
    }
}

extension MultiTaskCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    /*func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let previous = touch.previousLocation(in: self.containerView)
        let current = touch.location(in: self.containerView)
        
        if previous.x == current.x {
            return true
        }
        /*if touch.view == self.containerView {
            return true
        }*/
        
        return false
    }*/
}
