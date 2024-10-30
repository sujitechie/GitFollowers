//
//  GFTextField.swift
//  GITFollowers
//
//  Created by sujith on 23/09/24.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
        backgroundColor = .tertiarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        returnKeyType  = .go
        placeholder = "Enter a username"
    }
    
}
