//
//  GFItemInfoVC.swift
//  GITFollowers
//
//  Created by sujith on 30/10/24.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
    func didTapGithubProfile(user: User)
    func didTapGetFollowers(user: User)
}


class GFItemInfoVC: UIViewController {
    
    var stackView = UIStackView()
    var itemInfoViewOne = GFItemInfoView()
    var itemInfoViewtwo = GFItemInfoView()
    var actionButton = GFButton()
    
    var user: User!
    weak var delegate: ItemInfoVCDelegate?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureStackView()
        configureBackground()
        configureActionButton()
    }
    
    private func configureBackground() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func actionButtonTapped() {}
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewtwo)
    }
    
    private func layoutUI() {

        view.addSubviews(stackView, actionButton)
        
        let padding = 20.0
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    

}
