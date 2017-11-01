//
//  Session.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/24/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation

class Session
{
    var name:String
    var description:String
    var totalIncome:Double
    var totalHours:Double
    var totalParticiapnts:Int
    var participantsArray:[Worker]
    
    init(SessionTitle: String, Description: String)
    {
        name = SessionTitle
        description = Description
        totalIncome = 0
        totalHours = 0
        totalParticiapnts = 0
        participantsArray = []
    }
}
