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
}

class WorkerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var session: Session!
    var workers: [Worker]!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var clockInLabel: UILabel!
    @IBOutlet var clockOutLabel: UILabel!
    @IBOutlet var ClockInOutButton: UIButton!
    @IBOutlet var EditButton: UIButton!
    @IBOutlet var addWorkerNameInput: UITextField!
    @IBOutlet var workerTable: UITableView!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workerTable.delegate = self
        workerTable.dataSource = self
        addWorkerNameInput.delegate = self

        workers = session.participantsArray
        
        if workers.count != 0
        {
            initializeInfo(worker: workers[0])  // Initially displays worker at top of workers list
            selectedIndex = 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wCell", for: indexPath)
        cell.textLabel!.font = UIFont.systemFont(ofSize: 23.0)
        cell.textLabel!.adjustsFontSizeToFitWidth = true
        cell.textLabel!.numberOfLines = 1
        cell.textLabel!.textAlignment = .center
        cell.textLabel!.text = workers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        initializeInfo(worker: workers[selectedIndex])
    }
    
    // Shows the info of the selected worker - or the only worker if only one exists
    func initializeInfo(worker: Worker)
    {
        nameLabel.text = (worker.name)
        hoursLabel.text = String(describing: worker.hours.clean) + " hours"
        if (worker.clockIn != nil)
        {
            clockInLabel.text = String(describing: worker.clockIn)
        }
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
                workers.append(Worker(_name: addWorkerNameInput.text!))
                workers.sort(by: sorterForWorkerTable)
                session.participantsArray = workers
                workerTable.reloadData()
                
                if (workers.count == 1)
                {
                    initializeInfo(worker: workers[0])
                    selectedIndex = 0
                }
            }
            
            addWorkerNameInput.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
                editWorkerViewController.worker = workers[selectedIndex]
                editWorkerViewController.index = selectedIndex
                editWorkerViewController.session = session
            }
        }
    }
    
    // Sorts the worker list alphabetically - called everytime a worker is added
    func sorterForWorkerTable(this: Worker, that: Worker) -> Bool {
        return this.name < that.name
    }
}