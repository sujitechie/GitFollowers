//
//  FavouriteCell.swift
//  GITFollowers
//
//  Created by sujith on 04/11/24.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseIdentifier = "favouriteCell"
    let avatarView = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        avatarView.downloadImage(from: favourite.avatarUrl)
    }
    
    private func configure() {
        self.accessoryType = .disclosureIndicator
        
        let views = [avatarView, usernameLabel]
        addSubViews(to: contentView, subviews: views)
        
        let padding = 12.0
        
        NSLayoutConstraint.activate([
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }

}
