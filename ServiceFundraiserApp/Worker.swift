//
//  Worker.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/24/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
class Worker{
    public var firstName:String
    public var lastName:String
    public var clockIn:Date?
    private var _hours:Float
    
    var hours:Float{
        get { return _hours}
        set {
            if (newValue >= 0){
                _hours = newValue
            }
        }
    }
    
    
    init() {
        firstName = ""
        lastName = ""
        _hours = 0
        clockIn = nil
    }
    
    init(_first:String, _last:String) {
        firstName = _first
        lastName = _last
        _hours = 0
        clockIn = nil
    }
    
    init(_first:String, _last:String, _Start:Date) {
        firstName = _first
        lastName = _last
        _hours = 0
        clockIn = _Start
    }
    
    func addHours(hours:Float) -> Void{
        _hours += hours
    }
    
    func calculatePay(wage:Float)->Float{
        return wage * _hours
    }
}
