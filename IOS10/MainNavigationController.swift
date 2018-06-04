//
//  MainNavigationController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 02/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

// MARK: - ControlCenterState
private enum ControlCenterState {
    case closed
    case open
    
    var opposite: ControlCenterState {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

// MARK: - UINavigationController
class MainNavigationController: UINavigationController {
    
    // MARK: - Properties ControlCenter
    private let controlCenterOffset: CGFloat = 423
    private lazy var controlCenterView: UIView = {
        return ControlCenter()
    }()
    private var bottomConstraint = NSLayoutConstraint()
    
    // MARK: - Properties MultiTask
    private lazy var multiTaskVC: MultiTaskViewController = {
        return MultiTaskViewController.instance() as! MultiTaskViewController
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlCenterLayout()
        controlCenterView.addGestureRecognizer(panRecognizer)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: Constants.notificationName.statusBarTap.rawValue), object: .none, queue: .none) { _ in
            if !(UIApplication.currentViewController() is MultiTaskViewController) {
                self.present(self.multiTaskVC, animated: true, completion: nil)
            }
        }
        
        
    }
    
    // MARK: - controlCenterLayout
    private func controlCenterLayout() {
        controlCenterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlCenterView)
        controlCenterView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlCenterView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = controlCenterView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: controlCenterOffset)
        bottomConstraint.isActive = true
        controlCenterView.heightAnchor.constraint(equalToConstant: 433).isActive = true
    }
    
    // MARK: - ControlCenter Animation
    private var currentControlCenterState: ControlCenterState = .closed
    private var runningAnimators = [UIViewPropertyAnimator]()
    
    /// The progress of each animator
    private var animationProgress = [CGFloat]()
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(controlCenterViewPanned(recognizer:)))
        return recognizer
    }()
    
    private func animateTransitionIfNeeded(to state: ControlCenterState, duration: TimeInterval) {
    
        guard runningAnimators.isEmpty else { return }
        
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.controlCenterView.layer.cornerRadius = 20
            case .closed:
                self.bottomConstraint.constant = self.controlCenterOffset
                self.controlCenterView.layer.cornerRadius = 0
            }
            self.view.layoutIfNeeded()
        })
        
        transitionAnimator.addCompletion { position in
            
            // update state
            switch position {
            case .start:
                self.currentControlCenterState = state.opposite
            case .end:
                self.currentControlCenterState = state
            case .current:
                ()
            }
            
            switch self.currentControlCenterState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.controlCenterOffset
            }
            
            self.runningAnimators.removeAll()
        }
        
        transitionAnimator.startAnimation()
        runningAnimators.append(transitionAnimator)
    }
    
    @objc private func controlCenterViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            
            animateTransitionIfNeeded(to: currentControlCenterState.opposite, duration: 1)
            
            // pause all animations
            runningAnimators.forEach { $0.pauseAnimation() }
            
            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            
            let translation = recognizer.translation(in: controlCenterView)
            var fraction = -translation.y / controlCenterOffset
            
            // adjust the fraction for the current state and reversed state
            if currentControlCenterState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            
            let yVelocity = recognizer.velocity(in: controlCenterView).y
            let shouldClose = yVelocity > 0
            
            // no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            // reverse the animations based on their current state and pan motion
            switch currentControlCenterState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
}
