//
//  MultiTaskViewController.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 12/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MultiTaskViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MultiTaskCollectionViewCell.registerNibFor(collectionView: collectionView)
        
        // Animation CollectionViewLayout
        let layout = AnimatedCollectionViewLayout()
        layout.animator = CustomPageAttributesAnimator()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension MultiTaskViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MultiTaskHandler.shared.viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = MultiTaskCollectionViewCell.cellForCollectionView(collectionView: collectionView, indexPath: indexPath) as! MultiTaskCollectionViewCell
        let appIcon = Array(MultiTaskHandler.shared.viewControllers.keys)[indexPath.row]
        let vC = MultiTaskHandler.shared.viewControllers[appIcon]
        
        cell.appIconImageView.image = appIcon.icon
        cell.appNameLabel.text = appIcon.display
        cell.containerImageView.image = vC?.snapshotImage
        
        cell.onCommitKillApp = {
            MultiTaskHandler.shared.removeInStack(appIcon)
            collectionView.reloadData()
            
            if MultiTaskHandler.shared.viewControllers.count == 0 {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        return cell
    }
}

// MARK: UICollectionDelegate
extension MultiTaskViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: ADD Redirection MultiTaskHandler
    }
    
    // For Size CollectionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

