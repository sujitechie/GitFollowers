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
    
    deinit {
        avatarView.image = nil
        usernameLabel.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = nil
        usernameLabel.text = ""
    }
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        NetworkManager.shared.downloadImage(from: favourite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarView.image = image
            }
        }
    }
    
    private func configure() {
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubviews(avatarView, usernameLabel)
        
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
