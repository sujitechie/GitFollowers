//
//  String+Ext.swift
//  GITFollowers
//
//  Created by sujith on 30/10/24.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en-IN")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDispalyFormat() -> String {
        guard let date = convertToDate() else { return "NA" }
        return date.convertToMonthYearFormat()
    }
}

