//
//  SearchViewController.swift
//  GITFollowers
//
//  Created by sujith on 23/09/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let searchTextField = GFTextField()
    let getFollowersButton = GFButton(backgroundColour: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !searchTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoView()
        configureSearchTextField()
        configureGetFollowersButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchTextField.text = ""
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func pushFollowersListVC() {
        
        guard isUsernameEntered else {
            print("username not entered")
            presentAlertVCOnMainThread(alertTitle: "Empty Username", alertBody: "username is required to search the followers.", buttonTitle: "Ok")
            return
        }
        
        searchTextField.resignFirstResponder()
        let followersVC = FollowersListViewController(username: searchTextField.text!)
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    func configureLogoView() {
        logoImageView.image = Images.ghLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureGetFollowersButton() {
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
