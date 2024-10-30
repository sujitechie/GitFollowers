//
//  GFUserInfoHeaderVC.swift
//  GITFollowers
//
//  Created by sujith on 24/10/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    var user: User!
    
    let avatarImageView = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        configureUIElements()
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        avatarImageView.image = UIImage(named: "avatar-placeholder")
        nameLabel.text = "sujith"
        usernameLabel.text = "sujitechie"
        locationLabel.text = "IN"
        bioLabel.text = "nsinfi inuinu u siupi fd iusdo ifbu iusd iouf suidfi sduhf soid jfpoa ijairo oohsoif."
        locationImageView.image = UIImage(named: "avatar-placeholder")
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        nameLabel.text = user.name ?? ""
        usernameLabel.text = user.login
        locationLabel.text = user.location
        bioLabel.text = user.bio ?? ""
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .label
        
        
        locationImageView.contentMode = .scaleAspectFit
        bioLabel.numberOfLines = 3
        bioLabel.lineBreakMode = .byWordWrapping
    }
    
    func layoutUI() {

        let locationView = UIView()
        let locationViews = [locationImageView, locationLabel]
        addSubViews(to: locationView, subviews: locationViews)
        
        // add labels to stack view
        let labels = [usernameLabel, nameLabel, locationView]
        let labelsStackview = UIStackView(arrangedSubviews: labels)
        labelsStackview.axis = .vertical
        labelsStackview.spacing = 8
                
        // add subviews to view
        let subviews = [avatarImageView, labelsStackview, bioLabel]
        addSubViews(to: view, subviews: subviews)
        
        let padding = 20.0
        let middleSpacing = 12.0
        
        // autolayouts
        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 0),
            locationImageView.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 0),
            locationImageView.heightAnchor.constraint(equalToConstant: 30),
            locationImageView.widthAnchor.constraint(equalToConstant: 30),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 4),
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: 0),
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            
            labelsStackview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            labelsStackview.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: middleSpacing),
            labelsStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            labelsStackview.heightAnchor.constraint(equalToConstant: 110),
            
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: middleSpacing)
        ])
    }
    

}
