//
//  WorkerViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/30/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

// This is to not display a decimal in hours if the decimal is 0, and a maximum of 2 decimals
extension Float
{
    var clean: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
    
    var money: String
    {
        return String(format: "%.2f", self)
    }
}

class WorkerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var session: Session!
    var workers: [Worker]!
    @IBOutlet var addWorkerNameInput: UITextField!
    @IBOutlet var workerTable: UITableView!
    var sessionIndex: Int!
    var workerIndex: Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        workerTable.delegate = self
        workerTable.dataSource = self
        addWorkerNameInput.delegate = self
        workerTable.allowsSelection = false

        workers = session.participantsArray
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wCell", for: indexPath) as! WorkerTableViewCell
        cell.nameLabel.text = workers[indexPath.row].name
        cell.hoursWorkedLabel.text = "Hours Worked: " + workers[indexPath.row].hours.clean
        cell.incomeContributedLabel.text = "Income Contributed: $" + workers[indexPath.row].income.money
        cell.editButton.tag = indexPath.item
        
        cell.editButton.addTarget(self, action: #selector(setWorkerIndex), for: .touchDown)
        
        return cell
    }
    
    @objc func setWorkerIndex(sender: UIButton)
    {
        workerIndex = sender.tag
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 123
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 123
    }
    
    @IBAction func addWorker()
    {
        if addWorkerNameInput.text != ""
        {
            var workerAlreadyExists: Bool = false
            for workr in workers    // Checks to ensure the worker has not already been placed
            {
                if addWorkerNameInput.text == workr.name
                {
                    workerAlreadyExists = true
                    break
                }
            }
            
            if (!workerAlreadyExists)   // Does not allow duplicate workers
            {
                let newWorker: Worker = Worker(_name: addWorkerNameInput.text!)
                workers.append(newWorker)
                workers.sort(by: sorterForWorkerTable)
                session.participantsArray = workers
                session.totalParticipants = workers.count
                workerTable.reloadData()
            }
            
            addWorkerNameInput.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        addWorker()
        return true
    }
    
    // Only allows user to edit the worker's info if there's a worker
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if identifier == "toUpdateWorkerView"
        {
            if workers.count == 0
            {
                return false
            }
        }
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "backToSessionView"
        {
            if let sessionController = segue.destination as? SessionView {
                sessionController.currentSession = session
            }
        }
        
        if segue.identifier == "toUpdateWorkerView"
        {
            if let editWorkerViewController = segue.destination as? EditWorkerViewController
            {
                editWorkerViewController.workers = workers
                editWorkerViewController.worker = workers[workerIndex]
                editWorkerViewController.workerIndex = workerIndex
                editWorkerViewController.sessionIndex = sessionIndex
                editWorkerViewController.session = session
            }
        }
    }
    
    // Sorts the worker list alphabetically - called everytime a worker is added
    func sorterForWorkerTable(this: Worker, that: Worker) -> Bool {
        return this.name < that.name
    }
}
