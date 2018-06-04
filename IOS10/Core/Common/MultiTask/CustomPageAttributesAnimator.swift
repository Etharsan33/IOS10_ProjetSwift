//
//  CustomPageAttributesAnimator.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 12/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

/// An animator that _pushes_ the current cell into the screen while the next cell slide in.
public struct CustomPageAttributesAnimator: LayoutAttributesAnimator {
    /// The max scale that would be applied to the current cell. 0 means no scale. 0.2 by default.
    public var scaleRate: CGFloat
    
    public init(scaleRate: CGFloat = 0.2) {
        self.scaleRate = scaleRate
    }
    
    public func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes) {
        let position = attributes.middleOffset
        let contentOffset = collectionView.contentOffset
        print("Content : ", contentOffset)
        print("Position : ", position)
        let itemOrigin = attributes.frame.origin
        print("item : ", itemOrigin)
        let scaleFactor = scaleRate * min(position, 0) + 1.0
        var transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        print("Scale : ", scaleFactor)
        
        if attributes.scrollDirection == .horizontal {
            let xpos = position < 0 ? (contentOffset.x) - itemOrigin.x : 0
            print("XPOS : ", xpos)
            transform = transform.concatenating(CGAffineTransform(translationX: xpos, y: 0))
        } else {
            transform = transform.concatenating(CGAffineTransform(translationX: 0, y: position < 0 ? contentOffset.y - itemOrigin.y : 0))
        }
        
        attributes.transform = transform
        attributes.zIndex = attributes.indexPath.row
    }
}
