//
//  CommonFunctions.swift
//  RemoteNotificationSample
//
//  Created by Alok Singh on 11/08/17.
//  Skype           : alok.singh.confident
//  Phone/Whatsapp  : 8287757210
//  Email           : alok.singh.confident@gmail.com
//  Official Email  : alok.k.singh@orahi.com
//  Github          : https://github.com/aryansbtloe
//  LinkedIn        : https://in.linkedin.com/in/alok-kumar-singh-09141164
//  Facebook        : https://www.facebook.com/aryansbtloe
//  Stack OverFlow  : http://stackoverflow.com/users/911270/alok-singh
//  CocoaControls   : https://www.cocoacontrols.com/authors/aryansbtloe
//  Copyright (c) 2017 Orahi. All rights reserved.
//

import UIKit


// MARK: - NSDate

extension NSDate {
    func stringValue()->String {
        return (self as Date).stringValue()
    }
}

// MARK: - Date

let DefaultFormat = "EEE MMM dd HH:mm:ss Z yyyy"
let RSSFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
let AltRSSFormat = "d MMM yyyy HH:mm:ss ZZZ"

public enum ISO8601Format: String {
    case Year = "yyyy" // 1997
    case YearMonth = "yyyy-MM" // 1997-07
    case Date = "yyyy-MM-dd" // 1997-07-16
    case DateTime = "yyyy-MM-dd'T'HH:mmZ" // 1997-07-16T19:20+01:00
    case DateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ" // 1997-07-16T19:20:30+01:00
    case DateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1997-07-16T19:20:30.45+01:00
    init(dateString:String) {
        switch dateString.characters.count {
        case 4:
            self = ISO8601Format(rawValue: ISO8601Format.Year.rawValue)!
        case 7:
            self = ISO8601Format(rawValue: ISO8601Format.YearMonth.rawValue)!
        case 10:
            self = ISO8601Format(rawValue: ISO8601Format.Date.rawValue)!
        case 22:
            self = ISO8601Format(rawValue: ISO8601Format.DateTime.rawValue)!
        case 25:
            self = ISO8601Format(rawValue: ISO8601Format.DateTimeSec.rawValue)!
        default:// 28:
            self = ISO8601Format(rawValue: ISO8601Format.DateTimeMilliSec.rawValue)!
        }
    }
}

public enum DateFormat {
    case iso8601(ISO8601Format?), dotNet, rss, altRSS, custom(String)
}

public enum TimeZone {
    case local, utc
}

extension Date {
    
    /// EZSE: Initializes NSDate from string and format
    public init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = Date.init(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
    
    /// EZSE: Calculates how many days passed from now to date
    public func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }
    
    /// EZSE: Calculates how many hours passed from now to date
    public func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }
    
    /// EZSE: Calculates how many minutes passed from now to date
    public func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }
    
    /// EZSE: Calculates how many seconds passed from now to date
    public func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
    
    /// EZSE: Easy creation of time passed String. Can be Years, Months, days, hours, minutes or seconds
    public func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year!) \(str) ago"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month!) \(str) ago"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day!) \(str) ago"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour!) \(str) ago"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute!) \(str) ago"
        } else if components.second == 0 {
            return "Just now"
        } else {
            return "\(components.second!) seconds ago"
        }
    }
    
    /// EZSE: Easy creation of time passed String. Can be Years, Months, days, hours, minutes or seconds
    public func timePassedSince(date:Date) -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        var str: String
        
        if components.year! >= 1 {
            components.year == 1 ? (str = "year") : (str = "years")
            return "\(components.year!) \(str)"
        } else if components.month! >= 1 {
            components.month == 1 ? (str = "month") : (str = "months")
            return "\(components.month!) \(str)"
        } else if components.day! >= 1 {
            components.day == 1 ? (str = "day") : (str = "days")
            return "\(components.day!) \(str)"
        } else if components.hour! >= 1 {
            components.hour == 1 ? (str = "hour") : (str = "hours")
            return "\(components.hour!) \(str)"
        } else if components.minute! >= 1 {
            components.minute == 1 ? (str = "minute") : (str = "minutes")
            return "\(components.minute!) \(str)"
        } else if components.second == 0 {
            return "0 seconds"
        } else {
            return "\(components.second!) seconds"
        }
    }
    
    /// EZSE: Converts NSDate to String
    public func toStringValue(_ dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    /// EZSE: Converts NSDate to String, with format
    public func toStringValue(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// EZSE: Returns if dates are equal to each other
    static public func == (lhs: Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == .orderedSame
    }
    /// EZSE: Returns if one date is smaller than the other
    static public func < (lhs: Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }
    
    static public func > (lhs: Date, rhs: Date) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }
    
    func stringValue()->String{
        return self.toStringValue("yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    func stringTimeOnly_AM_PM_FormatValue()->String{
        return self.toStringValue("h:mm a")
    }
    
    func stringTimeComponentOnly()->String{
        return self.toStringValue("h:mm a").replacingOccurrences(of: "AM", with: "").replacingOccurrences(of: "PM", with: "")
    }
    
    func stringTimeOnly24HFormatValue()->String{
        return self.toStringValue("HH:mm:ss")
    }
    
    
    // MARK: Intervals In Seconds
    fileprivate static func minuteInSeconds() -> Double { return 60 }
    fileprivate static func hourInSeconds() -> Double { return 3600 }
    fileprivate static func dayInSeconds() -> Double { return 86400 }
    fileprivate static func weekInSeconds() -> Double { return 604800 }
    fileprivate static func yearInSeconds() -> Double { return 31556926 }
    
    // MARK: Components
    fileprivate static func componentFlags() -> NSCalendar.Unit { return [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second, NSCalendar.Unit.weekday, NSCalendar.Unit.weekdayOrdinal, NSCalendar.Unit.weekOfYear] }
    
    fileprivate static func components(_ fromDate: Date) -> DateComponents! {
        return (Calendar.current as NSCalendar).components(Date.componentFlags(), from: fromDate)
    }
    
    fileprivate func components() -> DateComponents  {
        return Date.components(self)!
    }
    
    func since() -> String {
        let seconds = abs(Date().timeIntervalSince1970 - self.timeIntervalSince1970)
        if seconds <= 120 {
            return "just now"
        }
        let minutes = Int(floor(seconds / 60))
        if minutes <= 60 {
            return "\(minutes) mins ago"
        }
        let hours = minutes / 60
        if hours <= 24 {
            return "\(hours) hrs ago"
        }
        if hours <= 48 {
            return "yesterday"
        }
        let days = hours / 24
        if days <= 30 {
            return "\(days) days ago"
        }
        if days <= 14 {
            return "last week"
        }
        let months = days / 30
        if months == 1 {
            return "last month"
        }
        if months <= 12 {
            return "\(months) months ago"
        }
        let years = months / 12
        if years == 1 {
            return "last year"
        }
        return "\(years) years ago"
    }
    
    func isEqualToDateIgnoringTime(_ date: Date) -> Bool
    {
        let comp1 = Date.components(self)
        let comp2 = Date.components(date)
        return ((comp1!.year == comp2!.year) && (comp1!.month == comp2!.month) && (comp1!.day == comp2!.day))
    }
    
    func isToday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(Date())
    }
    
    func isTomorrow() -> Bool
    {
        return self.isEqualToDateIgnoringTime(Date().dateByAddingDays(1))
    }
    
    func isYesterday() -> Bool
    {
        return self.isEqualToDateIgnoringTime(Date().dateBySubtractingDays(1))
    }
    
    func isSameWeekAsDate(_ date: Date) -> Bool
    {
        let comp1 = Date.components(self)
        let comp2 = Date.components(date)
        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if comp1?.weekOfYear != comp2?.weekOfYear {
            return false
        }
        // Must have a time interval under 1 week
        return abs(self.timeIntervalSince(date)) < Date.weekInSeconds()
    }
    
    func isThisWeek() -> Bool
    {
        return self.isSameWeekAsDate(Date())
    }
    
    func isNextWeek() -> Bool
    {
        let interval: TimeInterval = Date().timeIntervalSinceReferenceDate + Date.weekInSeconds()
        let date = Date(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    func isLastWeek() -> Bool
    {
        let interval: TimeInterval = Date().timeIntervalSinceReferenceDate - Date.weekInSeconds()
        let date = Date(timeIntervalSinceReferenceDate: interval)
        return self.isSameWeekAsDate(date)
    }
    
    func isSameYearAsDate(_ date: Date) -> Bool
    {
        let comp1 = Date.components(self)
        let comp2 = Date.components(date)
        return (comp1!.year == comp2!.year)
    }
    
    func isThisYear() -> Bool
    {
        return self.isSameYearAsDate(Date())
    }
    
    func isNextYear() -> Bool
    {
        let comp1 = Date.components(self)
        let comp2 = Date.components(Date())
        return (comp1!.year! == comp2!.year! + 1)
    }
    
    func isLastYear() -> Bool
    {
        let comp1 = Date.components(self)
        let comp2 = Date.components(Date())
        return (comp1!.year! == comp2!.year! - 1)
    }
    
    func isEarlierThanDate(_ date: Date) -> Bool
    {
        return self.compare(date) == .orderedAscending
    }
    
    func isLaterThanDate(_ date: Date) -> Bool
    {
        return self.compare(date) == .orderedDescending
    }
    
    func isInFuture() -> Bool
    {
        return self.isLaterThanDate(Date())
    }
    
    func isInPast() -> Bool
    {
        return self.isEarlierThanDate(Date())
    }
    
    func dateByAddingDays(_ days: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.day = days
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateBySubtractingDays(_ days: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.day = (days * -1)
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateByAddingHours(_ hours: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.hour = hours
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateBySubtractingHours(_ hours: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.hour = (hours * -1)
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateByAddingMinutes(_ minutes: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.minute = minutes
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateBySubtractingMinutes(_ minutes: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.minute = (minutes * -1)
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateByAddingSeconds(_ seconds: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.second = seconds
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateBySubtractingSeconds(_ seconds: Int) -> Date
    {
        var dateComp = DateComponents()
        dateComp.second = (seconds * -1)
        return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
    }
    
    func dateAtStartOfDay() -> Date
    {
        var components = self.components()
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    func dateAtEndOfDay() -> Date
    {
        var components = self.components()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return Calendar.current.date(from: components)!
    }
    
    func dateAtStartOfWeek() -> Date
    {
        let flags :NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.weekday]
        var components = (Calendar.current as NSCalendar).components(flags, from: self)
        components.weekday = Calendar.current.firstWeekday
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    func dateAtEndOfWeek() -> Date
    {
        let flags :NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.weekday]
        var components = (Calendar.current as NSCalendar).components(flags, from: self)
        components.weekday = Calendar.current.firstWeekday + 6
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components)!
    }
    
    func dateAtTheStartOfMonth() -> Date
    {
        var components = self.components()
        components.day = 1
        let firstDayOfMonthDate :Date = Calendar.current.date(from: components)!
        return firstDayOfMonthDate
    }
    
    func dateAtTheEndOfMonth() -> Date {
        var components = self.components()
        components.month = components.month! + 1
        components.day = 0
        let lastDayOfMonth :Date = Calendar.current.date(from: components)!
        return lastDayOfMonth
    }
    
    static func tomorrow() -> Date
    {
        return Date().dateByAddingDays(1).dateAtStartOfDay()
    }
    
    static func yesterday() -> Date
    {
        return Date().dateBySubtractingDays(1).dateAtStartOfDay()
    }
    
    func setTimeOfDate(_ hour: Int, minute: Int, second: Int) -> Date {
        var components = self.components()
        components.hour = hour
        components.minute = minute
        components.second = second
        return Calendar.current.date(from: components)!
    }
    
    func secondsAfterDate(_ date: Date) -> Int {
        return Int(self.timeIntervalSince(date))
    }
    
    func secondsBeforeDate(_ date: Date) -> Int {
        return Int(date.timeIntervalSince(self))
    }
    
    func minutesAfterDate(_ date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.minuteInSeconds())
    }
    
    func minutesBeforeDate(_ date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.minuteInSeconds())
    }
    
    func hoursAfterDate(_ date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.hourInSeconds())
    }
    
    func hoursBeforeDate(_ date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.hourInSeconds())
    }
    
    func daysAfterDate(_ date: Date) -> Int {
        let interval = self.timeIntervalSince(date)
        return Int(interval / Date.dayInSeconds())
    }
    
    func daysBeforeDate(_ date: Date) -> Int {
        let interval = date.timeIntervalSince(self)
        return Int(interval / Date.dayInSeconds())
    }
    
    func nearestHour () -> Int {
        let halfHour = Date.minuteInSeconds() * 30
        var interval = self.timeIntervalSinceReferenceDate
        if  self.seconds() < 30 {
            interval -= halfHour
        } else {
            interval += halfHour
        }
        let date = Date(timeIntervalSinceReferenceDate: interval)
        return date.hour()
    }
    
    func year () -> Int { return self.components().year!  }
    
    func month () -> Int { return self.components().month! }
    
    func week () -> Int { return self.components().weekOfYear! }
    
    func day () -> Int { return self.components().day! }
    
    func hour () -> Int { return self.components().hour! }
    
    func minute () -> Int { return self.components().minute! }
    
    func seconds () -> Int { return self.components().second! }
    
    func weekday () -> Int { return self.components().weekday! }
    
    func nthWeekday () -> Int { return self.components().weekdayOrdinal! }
    
    func monthDays () -> Int { return (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self).length }
    
    func firstDayOfWeek () -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds() * Double(self.components().weekday! - 1)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).day()
    }
    
    func lastDayOfWeek () -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds() * Double(self.components().weekday! - 1)
        let distanceToEndOfWeek = Date.dayInSeconds() * Double(7)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).day()
    }
    
    func isWeekday() -> Bool {
        return !self.isWeekend()
    }
    
    func isWeekend() -> Bool {
        let range = (Calendar.current as NSCalendar).maximumRange(of: NSCalendar.Unit.weekday)
        return (self.weekday() == range.location || self.weekday() == range.length)
    }
    
    func toString(_ format: DateFormat, timeZone: TimeZone = .local) -> String{
        var dateFormat: String
        let zone: Foundation.TimeZone
        switch format {
        case .dotNet:
            let offset = NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * self.timeIntervalSince1970
            return  "/Date(\(nowMillis)\(offset))/"
        case .iso8601(let isoFormat):
            dateFormat = (isoFormat != nil) ? isoFormat!.rawValue : ISO8601Format.DateTimeMilliSec.rawValue
            zone = Foundation.TimeZone.autoupdatingCurrent
        case .rss:
            dateFormat = RSSFormat
            zone = Foundation.TimeZone.autoupdatingCurrent
        case .altRSS:
            dateFormat = AltRSSFormat
            zone = Foundation.TimeZone.autoupdatingCurrent
        case .custom(let string):
            switch timeZone {
            case .local:
                zone = Foundation.TimeZone.autoupdatingCurrent
            case .utc:
                zone = Foundation.TimeZone(secondsFromGMT: 0)!
            }
            dateFormat = string
        }
        
        let formatter = Date.formatter(dateFormat, timeZone: zone)
        return formatter.string(from: self)
    }
    
    func toString(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool = false, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> String {
        let formatter = Date.formatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: doesRelativeDateFormatting, timeZone: timeZone, locale: locale)
        return formatter.string(from: self)
    }
    
    func weekdayToString() -> String {
        let formatter = Date.formatter()
        return formatter.weekdaySymbols[self.weekday()-1] as String
    }
    
    func shortWeekdayToString() -> String {
        let formatter = Date.formatter()
        return formatter.shortWeekdaySymbols[self.weekday()-1] as String
    }
    
    func veryShortWeekdayToString() -> String {
        let formatter = Date.formatter()
        return formatter.veryShortWeekdaySymbols[self.weekday()-1] as String
    }
    
    func monthToString() -> String {
        let formatter = Date.formatter()
        return formatter.monthSymbols[self.month()-1] as String
    }
    
    func shortMonthToString() -> String {
        let formatter = Date.formatter()
        return formatter.shortMonthSymbols[self.month()-1] as String
    }
    
    func veryShortMonthToString() -> String {
        let formatter = Date.formatter()
        return formatter.veryShortMonthSymbols[self.month()-1] as String
    }
    
    static let sharedDateFormatters : [String: DateFormatter] = {
        let instance = [String: DateFormatter]()
        return instance
    }()
    
    fileprivate static func formatter(_ format:String = DefaultFormat, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> DateFormatter {
        let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        var formatters = Date.sharedDateFormatters
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    
    fileprivate static func formatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> DateFormatter {
        var formatters = Date.sharedDateFormatters
        let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
        if let cachedDateFormatter = formatters[hashKey] {
            return cachedDateFormatter
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
            formatter.timeZone = timeZone
            formatter.locale = locale
            formatters[hashKey] = formatter
            return formatter
        }
    }
    
    fileprivate var calendar: Calendar {
        return Calendar.current
    }
    
    static func date(_ year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        let now = Date()
        return now.change(year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func change(_ year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date! {
        var c = self.components()
        c.year = year ?? self.year()
        c.month = month ?? self.month()
        c.day = day ?? self.day()
        c.hour = hour ?? self.hour()
        c.minute = minute ?? self.minute()
        return calendar.date(from: c)
    }
    
}
