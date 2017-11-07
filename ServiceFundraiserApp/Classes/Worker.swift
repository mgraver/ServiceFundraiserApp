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
    public var income:Float
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
        income = 0
    }
    
    init(_name:String) {
        name = _name
        _hours = 0
        income = 0
    }
    
    init(_name:String, _income:Float) {
        name = _name
        _hours = 0
        income = _income
    }
    
    init(_name:String, _income:Float, _hours:Float) {
        name = _name
        income = _income
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
        static let income = "WorkerIncome"
        static let hours = "workerHours"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: workerKey.name)
        aCoder.encode(income, forKey: workerKey.income)
        aCoder.encode(_hours, forKey: workerKey.hours)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: workerKey.name) as? String
            else {
                os_log("Failed to load worker name.", log: OSLog.default, type: .debug)
                return nil
        }
        
        let inc = aDecoder.decodeFloat(forKey: workerKey.income)
        let hrs = aDecoder.decodeFloat(forKey: workerKey.hours)
        
        self.init(_name: name, _income: inc, _hours: hrs)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? Worker else {return false}
        return self == obj
    }
}

func == (lhs: Worker, rhs: Worker) -> Bool
{
    return lhs.name == rhs.name
}


