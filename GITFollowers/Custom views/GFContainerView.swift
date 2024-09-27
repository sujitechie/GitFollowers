//
//  GFContainerView.swift
//  GITFollowers
//
//  Created by sujith on 25/09/24.
//

import UIKit

class GFContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    init(backgroundColour: UIColor, borderColour: UIColor) {
        super.init(frame: .zero)
        configure()
        self.backgroundColor = backgroundColour
        self.layer.borderColor = borderColour.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
