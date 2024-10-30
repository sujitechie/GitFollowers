//
//  UIView+Ext.swift
//  GITFollowers
//
//  Created by sujith on 24/10/24.
//

import UIKit

extension UIView {
    
    func addSubViews(to view: UIView, subviews: [UIView], tamic: Bool = false) {
        subviews.forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = tamic
        }
    }
}
