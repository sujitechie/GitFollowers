//
//  USerInfoViewController.swift
//  GITFollowers
//
//  Created by sujith on 24/10/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(username: String)
}

class UserInfoViewController: UIViewController {
    
    var userName: String!
    let scrollView: UIScrollView = UIScrollView(frame: .zero)
    let contentView: UIView = UIView()
    let headerView: UIView = UIView()
    let itemViewOne: UIView = UIView()
    let itemViewTwo: UIView = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: UserInfoVCDelegate?

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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(view)
        contentView.pinToEdges(scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func layoutUI() {

        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
        let padding = 20.0
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
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

extension UserInfoViewController: ItemInfoVCDelegate {
    
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


