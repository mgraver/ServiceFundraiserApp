//
//  SessionViewController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/17/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class SessionView: UIViewController
{    
    //MARK: passed variables
    var sessions:[Session]?
    var currentSession:Session?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Code...
        print(currentSession?.name)
    }
}
