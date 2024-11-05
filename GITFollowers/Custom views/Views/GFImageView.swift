//
//  GFImageView.swift
//  GITFollowers
//
//  Created by sujith on 07/10/24.
//

import UIKit

class GFImageView: UIImageView {
    
    let placeHolder = Images.placeholder
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        image = placeHolder
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
