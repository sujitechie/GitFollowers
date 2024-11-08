//
//  GFButton.swift
//  GITFollowers
//
//  Created by sujith on 23/09/24.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColour: UIColor, title: String) {
        self.init(frame: .zero)
        set(colour: backgroundColour, title: title)
    }
    
    private func configure() {
        configuration = .filled()
        configuration?.cornerStyle = .medium
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(colour: UIColor, title: String) {
        configuration?.baseBackgroundColor = colour
        configuration?.baseForegroundColor = .white
        configuration?.title = title
    }
    
}
