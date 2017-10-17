//
//  TimeStamp.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/11/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
class timeStamp{
    private var clockIn:Date
    private var clockOut:Date
    
    init(startTime:Date, finishTime:Date) {
        clockIn = startTime
        clockOut = finishTime
    }
    
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeString = formatter.string(from: clockIn)
        return timeString
    }
    
    func getFinishTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let timeString = formatter.string(from: clockOut)
        return timeString
    }
    
    func getDifference() -> String {
        let cal = Calendar.current
        var min:Int = cal.dateComponents([.minute], from: clockIn, to: clockOut).minute ?? 0
        var hour:Int = 0
        if min > 59 {
            hour = min / 60
            min -= 60 * hour
        }
        return String(format: "%02d:%02d", hour, min)
    }
}
