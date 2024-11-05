//
//  UITableView+Ext.swift
//  GITFollowers
//
//  Created by sujith on 05/11/24.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
