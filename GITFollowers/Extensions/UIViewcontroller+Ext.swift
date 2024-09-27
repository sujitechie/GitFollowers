//
//  UIViewcontroller+extension.swift
//  GITFollowers
//
//  Created by sujith on 25/09/24.
//

import UIKit

extension UIViewController {
    
    func presentAlertVCOnMainThread(alertTitle: String, alertBody: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, alertBody: alertBody, buttonTitle: buttonTitle)
            alertVC.preferredTransition = .crossDissolve
            alertVC.modalPresentationStyle = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
}
