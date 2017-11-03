//
//  Singleton.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 11/1/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation
import os.log
final class Singleton: NSObject, NSCoding
{
    static let sharedInstance = Singleton()
    var sessions: [Session]
    public var didAlreadyLoad:Bool = false
    
    //NScoding save destination
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("sessionRecords")
    
    private override init()
    {
        sessions = []
    }
    
    private init(sessions:[Session]) {
        self.sessions = sessions
    }
    
    public func saveSessions() {
        let isSuccesssfulSave = NSKeyedArchiver.archiveRootObject(sessions, toFile: Singleton.ArchiveURL.path)
        if isSuccesssfulSave {
            os_log("Sessions were saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Sessions failed to save.", log: OSLog.default, type: .debug)
        }
    }

    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sessions, forKey: "sessionsArray")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let savedSessions = aDecoder.decodeObject(forKey: "sessionsArray") as? [Session]
            else {
                os_log("Failed to load sessiosn into singleton", log: OSLog.default, type: .debug)
                return nil
        }
        
        self.init(sessions: savedSessions)
    }
}
