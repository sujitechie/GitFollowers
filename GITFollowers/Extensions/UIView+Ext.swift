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
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func pinToEdges(_ superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
