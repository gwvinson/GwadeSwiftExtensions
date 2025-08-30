//
//  Date.swift
//  Path
//
//  Created by Garret Vinson on 11/30/23.
//

import Foundation

extension Date {
    
    /// The first moment of a given date.
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// The date set to 11:59:59PM.
    public var endOfDay: Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self) ?? (self.startOfDay + 86_399)
    }
    
    /// Add one day to the date.
    public var nextDay: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 1, to: self) ?? (self + 86_4000)
    }
    
    /// Subtract one day from the date.
    public var previousDay: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -1, to: self) ?? (self - 86_4000)
    }
    
    /// Retrieve a copy of the date with it's granularity constrained to minutes.
    public var ignoringSeconds: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: components) ?? self
    }
    
    /// Retrieve a copy of the date with it's granularity constrained to seconds.
    public var ignoringMilliseconds: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        return calendar.date(from: components) ?? self
    }
    
    /// Return the hour from the date.
    public var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    public func atSecond(_ second: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        components.second = second
        return calendar.date(from: components) ?? self
    }
    
    public static var thirtyDaysAgo: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -29, to: Date.now) ?? (Date.now - (86_400 * 29))
    }
    
    /// Subtract a number of days from the date.
    public static func daysAgo(_ days: Int) -> Date {
        let calendar = Calendar.current
        let doubleDays = Double(days)
        return calendar.date(byAdding: .day, value: -days, to: Date.now) ?? (Date.now - (86_400 * doubleDays))
    }
    
    /// Add a number of days to the date.
    public func plusDays(_ days: Int) -> Date {
        let calendar = Calendar.current
        let doubleDays = Double(days)
        return calendar.date(byAdding: .day, value: days, to: self) ?? (self + (86_400 * doubleDays))
    }
    
    public static var sevenDaysAgo: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -6, to: Date.now) ?? (Date.now - (86_400 * 6))
    }
    
    public static var startOfSixMonthsAgo: Date {
        let calendar = Calendar.current
        let sixMonthsAgo = calendar.date(byAdding: .month, value: -6, to: Date()) ?? Date()
        return calendar.date(bySetting: .day, value: 1, of: sixMonthsAgo) ?? sixMonthsAgo
    }
    
    public static var startOfTwelveMonthsAgo: Date {
        let calendar = Calendar.current
        let twelveMonthsAgo = calendar.date(byAdding: .month, value: -12, to: Date()) ?? Date()
        return calendar.date(bySetting: .day, value: 1, of: twelveMonthsAgo) ?? twelveMonthsAgo
    }
    
    public static var startOfFiveYearsAgo: Date {
        let calendar = Calendar.current
        let fiveYearsAgo = calendar.date(byAdding: .month, value: -60, to: Date()) ?? Date()
        return calendar.date(bySetting: .day, value: 1, of: fiveYearsAgo) ?? fiveYearsAgo
    }
    
    public var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
    
    public var weekdayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    public var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: self)
    }
    
    /// Generate a random date within a date range.
    public static func random(in range: Range<Date>) -> Date {
        Date(
            timeIntervalSinceNow: .random(
                in: range.lowerBound.timeIntervalSinceNow...range.upperBound.timeIntervalSinceNow
            )
        )
    }
    
    /// Initialize a date from an ISO8601 string.
    public init?(iso8601String: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        guard let date = formatter.date(from: iso8601String) else {
            return nil
        }
        
        self = date
    }
}
