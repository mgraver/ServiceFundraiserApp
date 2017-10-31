//
//  Worker.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/24/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
class Worker{
    public var name:String
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
        name = ""
        _hours = 0
        clockIn = nil
    }
    
    init(_name:String) {
        name = _name
        _hours = 0
        clockIn = nil
    }
    
    init(_name:String, _Start:Date) {
        name = _name
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
