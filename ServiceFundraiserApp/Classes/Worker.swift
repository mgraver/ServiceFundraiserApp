//
//  Worker.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/24/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import os.log
class Worker: NSObject, NSCoding {
    
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
    
    
    override init() {
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
    
    init(_name:String, _Start:Date?, _hours:Float) {
        name = _name
        clockIn = _Start
        self._hours = _hours
    }
    
    func addHours(hours:Float) -> Void{
        _hours += hours
    }
    
    func calculatePay(wage:Float)->Float{
        return wage * _hours
    }
    
    //MARK: NScoding
    struct workerKey {
        static let name = "WorkerName"
        static let clockIn = "WorkerClockIn"
        static let hours = "workerHours"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: workerKey.name)
        aCoder.encode(clockIn, forKey: workerKey.clockIn)
        aCoder.encode(_hours, forKey: workerKey.hours)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: workerKey.name) as? String
            else {
                os_log("Failed to load worker name.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let clkIn = aDecoder.decodeObject(forKey: workerKey.clockIn) as? Date
        guard let hrs = aDecoder.decodeObject(forKey: workerKey.hours) as? Float
            else {
                os_log("Failed to load worker hours.", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(_name: name, _Start: clkIn, _hours: hrs)
    }
    
}

