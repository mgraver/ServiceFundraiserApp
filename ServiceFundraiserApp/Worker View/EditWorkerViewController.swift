//
//  editWokerViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/31/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

class EditWorkerViewController: UIViewController {
    
    var workers: [Worker]!
    var worker: Worker!
    var index: Int!
    var session: Session!
    
    @IBOutlet var newNameInput: UITextField!
    @IBOutlet var newHoursInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newNameInput.text = worker.name
        newHoursInput.text = String(worker._hours.clean)
    }
    
    func updateWorker()
    {
        worker._hours = (newHoursInput.text! as NSString).floatValue
        worker.name = newNameInput.text!
        workers[index] = worker
    }
    
    func deleteWorker()
    {
        workers.remove(at: index)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "backToWorkerView"
        {
            if let workerView = segue.destination as? WorkerViewController
            {
                workerView.session = session
                workerView.workers = workers
            }
        }
        
        if segue.identifier == "deletedWorker"
        {
            if let workerView = segue.destination as? WorkerViewController
            {
                deleteWorker()
                session.participantsArray = workers
                
                workerView.session = session
                workerView.workers = workers
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
            }
        }
    }
    

}