//
//  UIViewcontroller+extension.swift
//  GITFollowers
//
//  Created by sujith on 25/09/24.
//

import UIKit
import SafariServices

fileprivate var loadingView: UIView!

extension UIViewController {
    
    func presentAlertVCOnMainThread(alertTitle: String, alertBody: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, alertBody: alertBody, buttonTitle: buttonTitle)
            alertVC.preferredTransition = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingIndicatior() {
        loadingView = UIView(frame: view.bounds)
        loadingView.alpha = 0
        loadingView.backgroundColor = .systemBackground
        view.addSubview(loadingView)
        
        UIView.animate(withDuration: 0.25) {
            loadingView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
        }
    }
    
    func showEmptyStateView(with message: String, on view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        view.addSubview(emptyStateView)
        emptyStateView.frame = view.bounds
    }
    
    func addSubViews(to view: UIView, subviews: [UIView], tamic:Bool = false) {
        subviews.forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = tamic
            view.addSubview(subView)
        }
    }
    
    func presentSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
