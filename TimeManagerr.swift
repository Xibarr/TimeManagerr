//
//  TimeManager.swift
//  Just Chinese
//
//  Created by Romain Barthez on 26/01/16.
//  Copyright © 2016 Romain Barthez. All rights reserved.
//

import Foundation


// 1 - The TimeManager is used determine the period of the day on a device (Morning, Lunch, Afternoon, etc).

// 2 - You can also use to return the value .Dark at night and .Bright during day time. It can be used to adapt your app theme.

// 3 - Use currentTime() to return the current Time as a Tuple ex: for 19:29:05  (19, 29, 5)



class TimeManagerr {
    
    // Singletons are cool
    
    static let sharedInstance = TimeManagerr()
    
    // MARK: - Properties
    
    // Modify this tuple to adapt when to return .Dark or .Bright
    // Return Bright between Sunrise and Sunset (e.g: from 8:00 to 18:59)
    private var sun = (sunrise: 8, sunset: 19)
    
    private var date: NSDate // current date
    private var calendar: NSCalendar // user calendar
    private var formatter: NSDateFormatter
    var currentPeriod: timePeriod { return self.getCurrentPeriod() }
    var currentDarkness: darkOrBright { return self.getCurrentDarkness() }
    
    
    private init() {
        date = NSDate()
        calendar = NSCalendar.currentCalendar()
        formatter = NSDateFormatter()
    }
    
    
    
    // MARK: - Public Enums
    
    // Time periods of the day
    enum timePeriod {
        case Morning
        case Lunch
        case Afternoon
        case Dinner
        case Evening
        case Night
        case Unknown
    }
    
    // Dark or Bright?
    // Can be used to change your app theme
    enum darkOrBright { // Doesn't work well on Northpole
        case Dark
        case Bright
    }
    
    
    // MARK: - Private Functions
    
    // Refresh the date
    private func refresh() {
        date = NSDate()
    }
    
    // Return the time period of the day
    private func getCurrentPeriod() -> timePeriod {
        
        refresh()
        
        let time = currentTime()
        switch time.hour {
        case 5..<12:
            return .Morning
        case 12..<14:
            return .Lunch
        case 14..<19:
            return .Afternoon
        case 19..<21:
            return .Dinner
        case 21..<22:
            return .Evening
        default:
            return .Night
            
        }
    }
    
    // Return dark or bright
    // from 8:00am to 6:59pm returns Bright
    private func getCurrentDarkness() -> darkOrBright {
        
        refresh()
        
        let time = currentTime()
        switch time.hour {
        case sun.sunrise..<sun.sunset:
            return .Bright
        default:
            return .Dark
            
        }
        
    }
    
    // MARK: - Time related functions
    
    // Return current Time as a Tuple ex: for 19:29:05  (19, 29, 5)
    func currentTime() -> (hour: Int, minute: Int, second: Int) {
        let components = self.calendar.components([.Hour, .Minute, .Second], fromDate: self.date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        return (hour,minute,second)
        
    }
    // Similar function but using a custom Date
    func currentTime(fromDate date: NSDate) -> (hour: Int, minute: Int, second: Int) {
        let components = self.calendar.components([.Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        return (hour,minute,second)
    }
    
    
    
    // MARK: - Extra
    
    // Return current time into string, "10:56 PM" or "22:56"
    private func timeToString(show24h: Bool = false) -> String {
        formatter.timeStyle = .ShortStyle
        let time = self.formatter.stringFromDate(self.date)
        formatter.dateFormat = "HH:mm"
        let time24h = formatter.stringFromDate(date)
        
        return (show24h ? time24h : time)
    }
    
    private func timeToString(fromDate date: NSDate, show24h: Bool = false) -> String {
        formatter.timeStyle = .ShortStyle
        let time = self.formatter.stringFromDate(date)
        formatter.dateFormat = "HH:mm"
        let time24h = formatter.stringFromDate(date)
        
        return (show24h ? time24h : time)
    }
    
    
    
}