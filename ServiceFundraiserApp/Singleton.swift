//
//  Singleton.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 11/1/17.
//  Copyright © 2017 GL. All rights reserved.
//

import Foundation

final class Singleton
{
    static let sharedInstance = Singleton()
    var sessions: [Session]
    
    private init()
    {
        sessions = []
    }
    
}
