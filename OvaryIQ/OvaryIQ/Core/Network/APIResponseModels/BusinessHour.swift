//
//  BusinessHour.swift
//  Ding
//
//  Created by Mobcoder Technologies Private Limited on 11/12/21.
//  Copyright © 2021 Naveen. All rights reserved.
//

import Foundation

struct BusinessHour: Codable {
    var day: Int?
    var startTime: Int = 0
    var endTime: Int = 0
    var isSelected = false

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case startTime = "startTime"
        case endTime = "endTime"
    }

    func fromTime() -> String {
        // return Date.convertUnixTimestampToLocalDateStr(milliseconds: self.startTime, dateFormat: DateFormat.timeFormat)
        return self.numberToTime(num: self.startTime)
    }

    func toTime() -> String {
        // return Date.convertUnixTimestampToLocalDateStr(milliseconds: self.endTime, dateFormat: DateFormat.timeFormat)
        return self.numberToTime(num: self.endTime)
    }

//    func fromDate() -> Date? {
//        // return Date.convertUnixTimestampToLocalDate(milliseconds: self.startTime)
//
//        let hours = self.startTime / 100
//        let minutes = self.startTime % 100
//
//        return Date().setTime(hour: hours, min: minutes, sec: 0, timeZone: TimeZone.current)
//    }

//    func toDate() -> Date? {
//        // return Date.convertUnixTimestampToLocalDate(milliseconds: self.endTime)
//
//        let hours = self.endTime / 100
//        let minutes = self.endTime % 100
//        return Date().setTime(hour: hours, min: minutes, sec: 0, timeZone: TimeZone.current)
//    }

//    func defaultMinDate() -> Date? {
//        return Date().setTime(hour: 0, min: 0, sec: 0, timeZone: TimeZone.current)
//    }
//
//    func defaultMaxDate() -> Date? {
//        return Date().setTime(hour: 24, min: 0, sec: 0, timeZone: TimeZone.current)
//    }

    private func numberToTime(num: Int) -> String {
        var hours = num / 100
        let minutes = num % 100

        let ampm = hours < 12 ? "AM" : "PM"

        if hours > 12 {
            hours = hours % 12
        }

        let h_string = hours < 10 ? "0\(hours)" : "\(hours)"
        let m_string =  minutes < 10 ? "0\(minutes)" : "\(minutes)"

        return "\(h_string):\(m_string)" + " " + ampm
    }
}

