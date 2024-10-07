//
//  FollowersListViewController.swift
//  GITFollowers
//
//  Created by sujith on 24/09/24.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.isNavigationBarHidden = false
        
        NetworkManager.shared.getFollowers(userName: username, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let errorMessage):
                self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: errorMessage.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

   
}
