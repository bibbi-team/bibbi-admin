//
//  Color+Ext.swift
//  BibbiAdmin
//
//  Created by 김건우 on 4/20/24.
//

import Foundation

extension String {
    
    func toDate(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        return formatter.date(from: self)
    }
    
    func toDate(_ type: Date.CustomFormatStyle) -> Date? {
        return self.toDate(type.string)
    }
    
}

extension String.StringInterpolation {
    
    mutating func appendInterpolation(data: Data, using encoding: String.Encoding = .utf8) {
        guard let str = String(data: data, encoding: encoding) else {
            appendLiteral("Data Encoding Error")
            return
        }
        appendLiteral(str)
    }
    
}
