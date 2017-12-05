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
    var currentSession:Session!
    var currentSessionIndex:Int?
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    var recordDestination:Bool = false
    
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
        //Create an oberver to check when app goes into background.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveCurrentSession), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        //Initilize the sessiosn var
        sessions = Singleton.sharedInstance.sessions
        
        //Set label text
        titleLable.text = titlePre + currentSession!.name
        descLabel.text = descPre + currentSession!.sesDescription
        hoursLabel.text = hoursPre + "\(currentSession!.totalHours)"
        partipantsLabel.text = participantsPre + "\(currentSession!.totalParticipants)"
        incomeButton.isEnabled = true
        incomeButton.setTitle(String(format: "$%.2f", currentSession!.totalIncome), for: .normal)
    }
    
    
    //MARK: -Income Button
    @IBAction func onIncomeClick(_ sender: UIButton) {
        performSegue(withIdentifier: "SVtoIncomeEdit", sender: self)
    }
    
    //MARK: -BACK Button
    @IBAction func onBackClick(_ sender: UIButton) {
        if recordDestination {
            performSegue(withIdentifier: "SVtoRV", sender: self)
        } else {
            performSegue(withIdentifier: "SVtoVC", sender: self)
        }
    }
    
    @IBAction func deleteRecord(_ sender: UIButton) {
        let sessionIndex = Singleton.sharedInstance.sessions.index(of: currentSession)
        Singleton.sharedInstance.sessions.remove(at: sessionIndex!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SVtoIncomeEdit" {
            if let incomeController = segue.destination as? IncomeController{
                incomeController.editSession = currentSession
                slideInTransitioningDelegate.direction = .bottom
                incomeController.transitioningDelegate = slideInTransitioningDelegate
                incomeController.modalPresentationStyle = .custom
            }
        }
            
        if segue.identifier == "toWorkerViewController"
        {
            if let workerController = segue.destination as? WorkerViewController
            {
                workerController.session = currentSession
                workerController.sessionIndex = Singleton.sharedInstance.sessions.index(of: currentSession)
                workerController.recordDestination = self.recordDestination
            }
        }
        
    }
    
    //MARK: save data
    @objc func saveCurrentSession() {
        Singleton.sharedInstance.saveSessions()
    }
}
