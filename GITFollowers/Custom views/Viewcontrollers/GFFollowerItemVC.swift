//
//  GFFollowerItemVC.swift
//  GITFollowers
//
//  Created by sujith on 30/10/24.
//

import Foundation

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        itemInfoViewOne.set(type: .followers, count: user.followers)
        itemInfoViewtwo.set(type: .following, count: user.following)
        actionButton.set(backgroundColour: .systemGreen, title: "Github Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(user: user)
    }
}
