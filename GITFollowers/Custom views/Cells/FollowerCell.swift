//
//  FollowerCell.swift
//  GITFollowers
//
//  Created by sujith on 07/10/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "followerCell"
    let avatarView = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarView.image = image
            }
        }
    }
    
    private func configure() {
   
        contentView.addSubviews(avatarView, usernameLabel)
        
        let padding = 8.0
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            usernameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
