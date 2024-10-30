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
    
    init(backgroundColour: UIColor, title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColour
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColour: UIColor, title: String) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColour
    }
    
}
