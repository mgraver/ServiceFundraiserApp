//
//  Session.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/24/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import os.log

class Session: NSObject, NSCoding
{
    var name:String
    var sesDescription:String
    var totalIncome:Double
    var totalHours:Double
    var totalParticipants:Int
    var participantsArray:[Worker]
    
    init(SessionTitle: String, Description: String)
    {
        name = SessionTitle
        sesDescription = Description
        totalIncome = 0
        totalHours = 0
        totalParticipants = 0
        participantsArray = []
    }
    
    init(SessionTitle: String, Description: String, tIncome:Double,
         tHours:Double, tParticiapnts:Int, pArray:[Worker]) {
        
        name = SessionTitle
        sesDescription = Description
        totalIncome = tIncome
        totalHours = tHours
        totalParticipants = tParticiapnts
        participantsArray = pArray
    }
    
    struct sessionKey {
        static let name = "name"
        static let description = "description"
        static let totalIncome = "totalIncome"
        static let totalHours = "totalHours"
        static let totalParticipants = "totalParticipants"
        static let participantsArray = "participantsArray"
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: sessionKey.name)
        aCoder.encode(sesDescription, forKey: sessionKey.description)
        aCoder.encode(totalIncome, forKey: sessionKey.totalIncome)
        aCoder.encode(totalHours, forKey: sessionKey.totalHours)
        aCoder.encode(totalParticipants, forKey: sessionKey.totalParticipants)
        aCoder.encode(participantsArray, forKey: sessionKey.participantsArray)
    }
    
    func updateWorkersPay()
    {
        let payPerHour: Float = Float(totalIncome / totalHours)
        
        for worker in participantsArray
        {
            worker.income = worker.hours * payPerHour
        }
    }
    
    func updateSessionHours()
    {
        var hours: Double = 0.0
        
        for worker in participantsArray
        {
            hours += Double(worker.hours)
        }
        
        totalHours = hours
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: sessionKey.name) as? String
            else {
                os_log("Failed to decode Session name.", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let sesDescription = aDecoder.decodeObject(forKey: sessionKey.description) as? String
            else {
                os_log("Failed to decode Session description.", log: OSLog.default, type: .debug)
                return nil
        }
        guard let totalIncome = aDecoder.decodeObject(forKey: sessionKey.totalIncome) as? Double
            else {
                os_log("Failed to decode Session total Income.", log: OSLog.default, type: .debug)
                return nil
        }
        guard let totalHours = aDecoder.decodeObject(forKey: sessionKey.totalHours) as? Double
            else {
                os_log("Failed to decode Session total hours.", log: OSLog.default, type: .debug)
                return nil
        }
        guard let totalParticipants = aDecoder.decodeObject(forKey: sessionKey.totalParticipants) as? Int
            else {
                os_log("Failed to decode Session total particiapants.", log: OSLog.default, type: .debug)
                return nil
        }
        guard let participantsArray = aDecoder.decodeObject(forKey: sessionKey.participantsArray) as? [Worker]
            else {
                os_log("Failed to decode Session array.", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(SessionTitle: name, Description: sesDescription, tIncome: totalIncome, tHours: totalHours,
                  tParticiapnts: totalParticipants, pArray: participantsArray)
    }
    
}


