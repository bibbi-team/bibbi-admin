//
//  Date+Ext.swift
//  BibbiAdmin
//
//  Created by 김건우 on 4/20/24.
//

import Foundation

extension Date {
    enum CustomFormatStyle {
        case MDd
        case yyyyMD
        case dashYyyyMmDd
        case yyyyMDHMS
        
        var string: String {
            switch self {
            case .MDd:
                return "M.dd"
            case .yyyyMD:
                return "yyyy년 M월 d일"
            case .dashYyyyMmDd:
                return "yyyy-MM-dd"
            case .yyyyMDHMS:
                return "yyyy년 M월 d일 H:m:s"
            }
        }
    }
}

extension Date {
    func toFormatString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        return formatter.string(from: self)
    }
    
    func toFormatString(_ type: Date.CustomFormatStyle) -> String {
        return toFormatString(type.string)
    }
}

extension Date {
    var isToday: Bool {
        self.isEqual(with: Date())
    }
    
    func isEqual(
        _ components: Set<Calendar.Component> = [.year, .month, .day],
        with date: Date
    ) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        
        let date1 = calendar.dateComponents(components, from: self)
        let date2 = calendar.dateComponents(components, from: date)
        
        for component in components {
            if date1.value(for: component) != date2.value(for: component) {
                return false
            }
        }
        return true
    }
}

extension Date {
    var endOfDate: Date {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.date(byAdding: .day, value: 1, to: self)!
    }
}

extension Date {
    static var _now: Date {
        return Date()
    }
    
    static var _20240110: Date {
        let dateComponents = DateComponents(
            year: 2024,
            month: 1,
            day: 10
        )
        return Calendar.current.date(
            from: dateComponents
        )!
    }
}
