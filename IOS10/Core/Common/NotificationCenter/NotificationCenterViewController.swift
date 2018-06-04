//
//  NotificationCenterViewController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 03/06/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

class NotificationCenterViewController: UIViewController {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    //MARK: Properties
    var offset = CGPoint.zero
    var animator : UIDynamicAnimator!
    var container : UICollisionBehavior!
    var snap : UISnapBehavior!
    var dynamicItem : UIDynamicItemBehavior!
    var gravity : UIGravityBehavior!
    var panGestureReconizer : UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setup()
        
        // DEFAULT STATE
        self.panGestureEnded()
    }
    
    //MARK: Functions
    func setup() {
        self.panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(NotificationCenterViewController.handlePan(_:)))
        panGestureReconizer.cancelsTouchesInView = false
        self.panGestureReconizer.delegate = self
        
        self.view.addGestureRecognizer(panGestureReconizer)
        
        self.animator = UIDynamicAnimator(referenceView: self.view.superview!)
        
        self.dynamicItem = UIDynamicItemBehavior(items:  [self.view])
        self.dynamicItem.allowsRotation = false
        self.dynamicItem.elasticity = 0
        snap = UISnapBehavior(item: self.view, snapTo: CGPoint(x: self.view.superview!.frame.size.width / 2, y: self.view.superview!.frame.size.height))
        animator.addBehavior(snap)
        self.gravity = UIGravityBehavior(items: [self.view])
        self.gravity.gravityDirection = CGVector(dx: 0, dy: -1)
        
        self.container = UICollisionBehavior(items: [self.view])
        
        configureContainer()
        
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
    }
    
    func configureContainer() {
        let boundaryWidth = UIScreen.main.bounds.size.width
        container.addBoundary(withIdentifier: "upper" as NSCopying, from: CGPoint(x: 0, y: -self.view.frame.size.height + 30), to: CGPoint(x: boundaryWidth, y: -self.view.frame.size.height + 30))
        let boundaryHeight = UIScreen.main.bounds.size.height
        container.addBoundary(withIdentifier: "lower" as NSCopying, from: CGPoint(x: 0, y: boundaryHeight), to: CGPoint(x: boundaryWidth, y: boundaryHeight))
    }
    
    @objc func handlePan(_ pan : UIPanGestureRecognizer) {
        let velocity = pan.velocity(in: self.view.superview).y
        var location = pan.location(in: self.view.superview!)
        var movement = self.view.frame
        
        movement.origin.x = 0
        movement.origin.y = movement.origin.y + (velocity * 0.05)
        if pan.state == .ended{
            panGestureEnded()
        }else if pan.state == .began {
            let center = self.view.center
            offset.y = location.y - center.y
            snapToBottom()
        }else{
            animator.removeBehavior(snap)
            
            location.x -= offset.x
            location.y -= offset.y
            
            location.x = self.view.superview!.frame.width / 2
            snap = UISnapBehavior(item: self.view, snapTo: location)
            
            animator.addBehavior(snap)
        }
        
    }
    
    func panGestureEnded() {
        animator.removeBehavior(snap)
        
        let velocity = dynamicItem.linearVelocity(for: self.view)
        
        if fabsf(Float(velocity.y)) > 250 {
            if velocity.y < 0{
                snapToTop()
            }else{
                snapToBottom()
            }
        }else{
            if let superViewHeight = self.view.superview?.bounds.size.height{
                if self.view.frame.origin.y > superViewHeight / 2{
                    snapToBottom()
                }else{
                    snapToTop()
                }
            }
        }
    }
    
    func snapToBottom() {
        gravity.gravityDirection  = CGVector(dx: 0, dy: 2.5)
    }
    
    func snapToTop() {
        gravity.gravityDirection  = CGVector(dx: 0, dy: -2.5)
    }
}

// MARK: detect which view you touch
extension NotificationCenterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let contentView = self.visualEffectView.contentView
        return touch.view == contentView
    }
}
