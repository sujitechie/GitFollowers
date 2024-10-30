//
//  FollowersListViewController.swift
//  GITFollowers
//
//  Created by sujith on 24/09/24.
//

import UIKit

enum Section {
    case main
}

class FollowersListViewController: UIViewController {
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    var hasMoreFollowers: Bool = true
    var page: Int = 1
    var isSearching: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDatasource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    }
    
    func configureDatasource() {
        
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search followers"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        datasource.apply(snapshot, animatingDifferences: true)
    }

    func getFollowers(username: String, page: Int) {
        showLoadingIndicatior()
        NetworkManager.shared.getFollowers(userName: username, page: page) {
            [weak self] result in
            self?.hideLoadingIndicator()
            guard let self = self else { return }

            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This user does not have any followers."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, on: self.view)
                    }
                }
                
                self.updateData(with: self.followers)
            case .failure(let errorMessage):
                self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        // print("offset Y : \(offsetY)")
        // print("contentHeight : \(contentHeight)")
        // print("height: \(height)")
        if offsetY > contentHeight - height - 150 {
            // fetch more followers
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFollowersArray = isSearching ? filteredFollowers : followers
        let follower = currentFollowersArray[indexPath.item]
        
        let destVC = UserInfoViewController()
//        let destVC = GFUserInfoHeaderVC()
        
        destVC.userName = follower.login
        let navigationController = UINavigationController(rootViewController: destVC)
        DispatchQueue.main.async {
            self.present(navigationController, animated: true)
        }
    }
}

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchName = searchController.searchBar.text, !searchName.isEmpty else {
            return
        }
        isSearching = true
        filteredFollowers = followers.filter({ follower in
            return follower.login.lowercased().contains(searchName.lowercased())
        })
        updateData(with: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: self.followers)
        isSearching = false
    }
    
}
