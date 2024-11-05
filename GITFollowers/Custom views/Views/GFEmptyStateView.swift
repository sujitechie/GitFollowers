//
//  GFEmptyStateView.swift
//  GITFollowers
//
//  Created by sujith on 23/10/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 24)
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    func configure() {
        addSubviews(messageLabel, imageView)
        imageView.image = Images.emptyStateLogo
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            messageLabel.heightAnchor.constraint(equalToConstant: 300),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 150),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50)
        ])
        
        
    }
}
