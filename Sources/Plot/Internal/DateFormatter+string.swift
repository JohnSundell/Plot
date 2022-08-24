//
//  DateFormatter+string.swift
//  
//
//  Created by Harry Day on 24/08/2022
//  
//
//  Twitter: https://twitter.com/harrydayexe
//  Github: https://github.com/harrydayexe
//
    

import Foundation

internal extension DateFormatter {
    /// Convert a date object into a RF361 compliant datetime string.
    /// - parameter date: The date object to convert to a string.
    static func ISOstring(from date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        
        return df.string(from: date)
    }
}
