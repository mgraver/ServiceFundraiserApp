//
//  ViewController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/11/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
import os.log
class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !Singleton.sharedInstance.didAlreadyLoad
        {
            Singleton.sharedInstance.didAlreadyLoad = true
            loadSessions()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Load privous sessions.
    public func loadSessions() {
        let loadedSessions = NSKeyedUnarchiver.unarchiveObject(withFile: Singleton.ArchiveURL.path) as? [Session]
        //if saved data exits load it.
        if loadedSessions != nil {
            Singleton.sharedInstance.sessions = loadedSessions!
        } else {
            os_log("No previous data was found.", log: OSLog.default, type: .debug)
        }
        
    }
    

}

