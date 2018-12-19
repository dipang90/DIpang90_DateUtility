//
//  DateUtility.swift
//  DIpang90_DateUtility
//
//  Created by Dipang Sheth on 19/12/18.
//  Copyright © 2018 Dipang Sheth. All rights reserved.
//

import Foundation


struct DateUtil {
    static var formate = "yyyy-MM-dd"
    static var timeZone = ""
    static var locale = ""
    static let calendar = Calendar.current
    static let dateFormate = dateFormatter()
    
    //MARK: - DateFormater
    static func dateFormatter(formate : String = formate) -> DateFormatter {
        let formatter : DateFormatter  = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        if !self.timeZone.isEmpty {
            formatter.timeZone = TimeZone(identifier: self.timeZone)
        }
        if !self.locale.isEmpty {
            formatter.locale = Locale(identifier: self.locale)
        }
        return formatter
    }
    
    //MARK: - Milliscond
    static func milliscond(_ date : Date = Date()) -> Int64 {
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    static func milliscondFromStringDate(_ string : String) -> Int64 {
        let date = dateFormate.date(from: string)!
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    static func dateFromMiliscond (_ millisecond : Int) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(millisecond)/1000)
        return date
    }
    
    static func stringDateFromMiliscond(_ millisecond : Int) -> String {
        let stringDate = Date(timeIntervalSince1970: TimeInterval(millisecond)/1000)
        return self.dateFormate.string(from: stringDate)
    }
    
    //MARK: - Date & String
    static func stringFromDate(_ date : Date, format : String = formate ) -> String {
        return dateFormatter(formate: format).string(from: date)
    }
    static func dateFromString(_ string : String) -> Date {
        let date = dateFormate.date(from: string)!
        let somedateString = dateFormate.string(from: date)
        guard let returnDate = dateFormate.date(from: somedateString) else {
            return Date()
        }
        return returnDate
    }
    static func stringTimeFromDate(_ date : Date) -> String {
        return dateFormatter(formate: "hh:mm").string(from: date)
    }
    
    
    //MARK: - Date comparator
    static func dateComparator(_ start : String, _ end : String) -> (isDateSame: Bool , isDateGreater : Bool , isDateLess : Bool ) {
        var isDateSame : Bool = false
        var isDateGreater : Bool = false
        var isDateLess : Bool = false
        
        guard let startDate = dateFormate.date(from: start) else {
            return (isDateSame, isDateGreater, isDateLess)
        }
        guard let endDate = dateFormate.date(from: end) else {
            return (isDateSame, isDateGreater, isDateLess)
        }
        
        if startDate.compare(endDate) == .orderedSame {
            isDateSame = true
        }
        if startDate.compare(endDate) == .orderedDescending {
            isDateGreater = true
        }
        if startDate.compare(endDate) == .orderedAscending {
            isDateLess = true
        }
        return (isDateSame, isDateGreater, isDateLess)
    }
    
    //MARK: - Date Yesterday, Today, Tomorrow,
    static func isDay(_ string : String) -> (Yesterday: Bool , Today : Bool , Tomorrow : Bool, Weekend : Bool ) {
        
        var Yesterday : Bool = false
        var Today : Bool = false
        var Tomorrow : Bool = false
        var Weekend : Bool = false
        
        guard let date = dateFormate.date(from: string) else {
            return (Yesterday: Yesterday , Today : Today , Tomorrow : Tomorrow, Weekend : Weekend )
        }
        
        Yesterday = self.calendar.isDateInYesterday(date)
        Today = self.calendar.isDateInToday(date)
        Tomorrow = self.calendar.isDateInTomorrow(date)
        Weekend = self.calendar.isDateInWeekend(date)
        return (Yesterday: Yesterday , Today : Today , Tomorrow : Tomorrow, Weekend : Weekend)
    }
    
    //MARK: - Date component
    
    static func  dateComponent(_ date : Date = Date()) -> (year: Int?, month : Int?, day : Int?, hour : Int?
        , minuts : Int?, second : Int?){
            
            let components = self.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let year = components.year != nil  ?  components.year : 0
            let month = components.month != nil  ?  components.month : 0
            let day = components.day != nil  ?  components.day : 0
            let hour = components.hour != nil  ?  components.hour : 0
            let minuts = components.minute != nil  ?  components.minute : 0
            let second = components.second != nil  ?  components.second : 0
            return (year!,month!,day!,hour!,minuts!,second!)
    }
    
    
    static func isCurrentDate1(dateValue : String) -> Bool {
        if !dateValue.isEmpty {
            let someDate = dateFormate.date(from: dateValue)!
            let calendar = Calendar.current
            let flags : NSCalendar.Unit = [.day, .month, .year]
            let components = (calendar as NSCalendar).components(flags, from: Date())
            let today = calendar.date(from: components)
            if (someDate as NSDate).timeIntervalSince(today!).sign == .minus {
                //someDate is berofe than today
                return true
            } else {
                return false
                //someDate is equal or after than today
            }
        }
        return false
    }
    
    static func UTCtoLocalDate(string : String, dateFormate : String = "yyyy-MM-dd'T'HH:mm:ss+SSSS") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: string) else {
            return string
        }
        return self.stringFromDate(date, format: "yyyy-MM-dd hh:mm")
    }
    
    static func featureDate(_ value : Int, date : Date) -> String {
        let addedDate = Calendar.current.date(byAdding: .day, value: value, to:date)
        let serviceDate = DateUtil.stringFromDate(addedDate!)
        return serviceDate
    }
    
    static func pastDate(_ value : Int, date : Date) -> String {
        let addedDate = Calendar.current.date(byAdding: .day, value: (-value), to:date)
        let serviceDate = DateUtil.stringFromDate(addedDate!)
        return serviceDate
    }
}

