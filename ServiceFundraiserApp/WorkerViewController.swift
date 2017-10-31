//
//  WorkerViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/30/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

class WorkerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CURRENT SESSION: " + session.name)

        if (session.participantsArray != nil)
        {
            workers = []
        }
        else
        {
            workers = session.participantsArray
        }
        
        if workers.count != 0
        {
            initializeInfo(worker: workers[0])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workerNameCell", for: indexPath)
        cell.textLabel?.text = workers[indexPath.row].name
        return cell
    }
    
    func initializeInfo(worker: Worker?)
    {
        nameLabel.text = (worker?.name)
        hoursLabel.text = String(describing: worker?.hours)
        clockInLabel.text = String(describing: worker?.clockIn)
    }
    
    @IBAction func addWorker()
    {
        if addWorkerNameInput.text != ""
        {
            
            workers.append(Worker(_name: addWorkerNameInput.text!))
            session.participantsArray = workers
            workerTable.reloadData()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
