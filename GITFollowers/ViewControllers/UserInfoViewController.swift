//
//  USerInfoViewController.swift
//  GITFollowers
//
//  Created by sujith on 24/10/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoViewController: UIViewController {
    
    var userName: String!
    let headerView: UIView = UIView()
    let itemViewOne: UIView = UIView()
    let itemViewTwo: UIView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: FollowersListVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(userName: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.configureUI(with: user)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureUI(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Since \(user.createdAt.convertToDispalyFormat())"
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {
        let views = [headerView, itemViewOne, itemViewTwo, dateLabel]
        addSubViews(to: view, subviews: views)
        let padding = 20.0
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView ) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc
    func dismissVC() {
        dismiss(animated: true)
    }
    
}

extension UserInfoViewController: UserInfoVCDelegate {
    
    func didTapGithubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertVCOnMainThread(alertTitle: "Invalid URL", alertBody: "This user does nor have a valid profile url.", buttonTitle: "OK")
            return
        }
        presentSafariVC(url: url)
        
    }
    
    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            presentAlertVCOnMainThread(alertTitle: "No Followers", alertBody: "This user have no followers.", buttonTitle: "OK")
            return
        }
        delegate?.didRequestFollowers(username: user.login)
        dismissVC()
    }
}


