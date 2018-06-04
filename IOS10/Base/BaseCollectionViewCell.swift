//
//  BaseCollectionViewCell.swift
//  IOS10
//
//  Created by ELANKUMARAN Tharsan on 12/05/2018.
//  Copyright © 2018 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

open class BaseCollectionViewCell : UICollectionViewCell {
    
    //MARK: Instance
    class public func registerNibFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: self))
    }
    
    class open func cellForCollectionView(collectionView: UICollectionView, indexPath : IndexPath) -> BaseCollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! BaseCollectionViewCell
    }
    
}
