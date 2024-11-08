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

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationController?.isNavigationBarHidden = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        showLoadingIndicatior()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(userName: username)
                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentAlertVCOnMainThread(alertTitle: "Success", alertBody: "User added to favourites🎉🎉", buttonTitle: "Ok")
                        return
                    }
                    self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: error.rawValue, buttonTitle: "Ok")
                }
                hideLoadingIndicator()
            } catch {
                if let error = error as? GFError {
                    self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: error.rawValue, buttonTitle: "Ok")
                } else {
                    self.presentDefaultError()
                }
                hideLoadingIndicator()
            }
        }
        
//        old network call to fetch user info
//        NetworkManager.shared.getUserInfo(userName: username) { [weak self] result in
//            guard let self = self else { return }
//            self.hideLoadingIndicator()
//            switch result {
//            case .success(let user):
//                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
//                PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
//                    guard let self = self else { return }
//                    guard let error = error else {
//                        self.presentAlertVCOnMainThread(alertTitle: "Success", alertBody: "User added to favourites🎉🎉", buttonTitle: "Ok")
//                        return
//                    }
//                    self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: error.rawValue, buttonTitle: "Ok")
//                }
//            case .failure(let error):
//                self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: error.rawValue, buttonTitle: "Ok")
//            }
//        }
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
        
        Task {
            do {
                
                let followers = try await NetworkManager.shared.getFollowers(userName: username, page: page)
                if followers.count < 100 {
                    hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This user does not have any followers."
                    showEmptyStateView(with: message, on: view)
                }
                updateData(with: self.followers)
                hideLoadingIndicator()
                
            } catch {
                if let error = error as? GFError {
                    presentAlertVC(alertTitle: "Something went wrong", alertBody: error.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                hideLoadingIndicator()
            }
        }
        
        
        
//        Calling network magager using old way of completion handlers
//        NetworkManager.shared.getFollowers(userName: username, page: page) {
//            [weak self] result in
//            self?.hideLoadingIndicator()
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let followers):
//                if followers.count < 100 {
//                    hasMoreFollowers = false
//                }
//                self.followers.append(contentsOf: followers)
//                
//                if followers.isEmpty {
//                    let message = "This user does not have any followers."
//                    DispatchQueue.main.async {
//                        self.showEmptyStateView(with: message, on: self.view)
//                    }
//                }
//                
//                self.updateData(with: self.followers)
//            case .failure(let errorMessage):
//                self.presentAlertVCOnMainThread(alertTitle: "Something went wrong", alertBody: errorMessage.rawValue, buttonTitle: "Ok")
//            }
//        }
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
        destVC.userName = follower.login
        destVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: destVC)
        DispatchQueue.main.async {
            self.present(navigationController, animated: true)
        }
    }
}

extension FollowersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchName = searchController.searchBar.text, !searchName.isEmpty else {
            updateData(with: self.followers)
            isSearching = false
            filteredFollowers.removeAll()
            return
        }
        isSearching = true
        filteredFollowers = followers.filter({ follower in
            return follower.login.lowercased().contains(searchName.lowercased())
        })
        updateData(with: filteredFollowers)
    }
}

extension FollowersListViewController: UserInfoVCDelegate {
    
    func didRequestFollowers(username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
//        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
