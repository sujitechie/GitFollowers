//
//  Date+Ext.swift
//  GITFollowers
//
//  Created by sujith on 30/10/24.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
