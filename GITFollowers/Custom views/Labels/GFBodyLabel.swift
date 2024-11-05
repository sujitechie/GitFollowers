//
//  GFBodyLabel.swift
//  GITFollowers
//
//  Created by sujith on 24/09/24.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        minimumScaleFactor = 0.75
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
    }
    
}
