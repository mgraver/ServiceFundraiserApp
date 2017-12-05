//
//  editWokerViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/31/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

class EditWorkerViewController: UIViewController
{    
    var workers: [Worker]!
    var worker: Worker!
    var sessionIndex: Int!
    var workerIndex: Int!
    var session: Session!
    var recordDestination:Bool = false
    
    @IBOutlet var newNameInput: UITextField!
    @IBOutlet var newHoursInput: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        session = Singleton.sharedInstance.sessions[sessionIndex]
        
        newNameInput.text = worker.name
        
        if worker.hours != 0
        {
            newHoursInput.text = String(worker.hours.clean)
        }
    }
    
    func updateWorker()
    {
        if newHoursInput.text != ""
        {
            worker.hours = (newHoursInput.text! as NSString).floatValue
        }
        else
        {
            worker.hours = 0
        }
        
        if newNameInput.text != ""
        {
            worker.name = newNameInput.text!
        }
        else
        {
            worker.name = "No Name"
        }
        
        workers[workerIndex] = worker
        session.updateSessionHours()
        session.updateWorkersPay()
    }
    
    func deleteWorker()
    {
        workers.remove(at: workerIndex)
        session.participantsArray = workers
        session.totalParticipants = workers.count
        session.updateSessionHours()
        session.updateWorkersPay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "backToWorkerView"
        {
            if let workerView = segue.destination as? WorkerViewController
            {
                workerView.session = session
                workerView.workers = workers
                workerView.sessionIndex = sessionIndex
                workerView.workerIndex = workerIndex
                workerView.recordDestination = self.recordDestination
            }
        }
        
        if segue.identifier == "deletedWorker"
        {
            if let workerView = segue.destination as? WorkerViewController
            {
                deleteWorker()
                
                workerView.session = session
                workerView.workers = workers
                workerView.sessionIndex = sessionIndex
                workerView.recordDestination = self.recordDestination
                Singleton.sharedInstance.sessions[sessionIndex] = session
            }
        }
        
        if segue.identifier == "update"
        {
            if let workerView = segue.destination as? WorkerViewController
            {
                updateWorker()
                session.participantsArray = workers
                
                workerView.session = session
                workerView.workers = workers
                workerView.sessionIndex = sessionIndex
                workerView.workerIndex = workerIndex
                workerView.recordDestination = self.recordDestination
                Singleton.sharedInstance.sessions[sessionIndex] = session
            }
        }
    }
    

}
