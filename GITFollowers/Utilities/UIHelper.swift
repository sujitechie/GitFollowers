//
//  UIHelper.swift
//  GITFollowers
//
//  Created by sujith on 07/10/24.
//

import UIKit

enum UIHelper {
    
    static  func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        let availbleWidth = width - (padding * 2 ) - (spacing * 2)
        let itemWidth = availbleWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        
        return flowLayout
    }
}
