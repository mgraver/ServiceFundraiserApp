//
//  SessionViewController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/17/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class SessionView: UIViewController{
    
    //MARK:passed variables
    var sessions:[Session]?
    var currentSession:Session?
    
    //MARK:labelPrefixes
    let titlePre = "Session Title: "
    let descPre = "Description: "
    let hoursPre = "Total Hours: "
    let participantsPre = "Total Participants: "
    
    //MARK:UIProperties
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var partipantsLabel: UILabel!
    @IBOutlet weak var incomeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.text = titlePre + currentSession!.name
        descLabel.text = descPre + currentSession!.description
        hoursLabel.text = hoursPre + "\(currentSession!.totalHours)"
        partipantsLabel.text = participantsPre + "\(currentSession!.totalParticiapnts)"
        incomeButton.isEnabled = true
        incomeButton.setTitle(String(format: "$%.2f", currentSession!.totalIncome), for: .normal)
    }
}
