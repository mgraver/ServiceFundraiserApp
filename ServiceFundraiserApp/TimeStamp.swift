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
        //TODO: Fix this funtion.
        let cal = NSCalendar.current
        let hour = cal.dateComponents([.hour], from: clockIn, to: clockOut)
        let min = cal.dateComponents([.minute], from: clockIn, to: clockOut)
        return "\(hour):\(min)"
    }
}
