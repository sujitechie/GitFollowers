//
//  GFRepoItemVC.swift
//  GITFollowers
//
//  Created by sujith on 30/10/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        itemInfoViewOne.set(type: .repos, count: user.publicRepos)
        itemInfoViewtwo.set(type: .gists, count: user.publicGists)
        actionButton.set(backgroundColour: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGithubProfile(user: user)
    }
}
