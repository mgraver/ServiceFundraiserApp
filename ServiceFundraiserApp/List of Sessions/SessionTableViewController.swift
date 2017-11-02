//
//  SessionTableViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/27/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

protocol TableViewControllerDelegate
{
    func didSelectItem(name: String, description: String)
}

class SessionTableViewController: UITableViewController {

    var sessions: [Session] = []
    var searchedSessions: [Session] = []
    var selectedSession: Session?
    var delegate:TableViewControllerDelegate! = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Placeholder to fill session values
        for i in 0...10
        {
            sessions.append(Session(SessionTitle: "Blood Drive " + String(i), Description: "Giving away free blood!"))
        }
        
        fillTable(query: "")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchedSessions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SessionTableViewCell
        
        cell.projectName.text = searchedSessions[indexPath.row].name
        cell.projectInfo.text = searchedSessions[indexPath.row].sesDescription
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "viewSelectedSession"
        {
            let destination = segue.destination as! SessionView
            let indexPath = self.tableView.indexPathForSelectedRow!
            destination.currentSession = searchedSessions[indexPath.row]
        }
    }
    
    // Fills the session table with what the user searched, or with all sessions if they aren't searching
    func fillTable(query: String)
    {
        if (query != "")
        {
            searchedSessions.removeAll()
            for session in sessions
            {
                if (session.name.range(of: query) != nil || session.description.range(of: query) != nil)
                {
                    searchedSessions.append(session)
                }
            }
        }
        else
        {
            searchedSessions = sessions
        }
        self.tableView.reloadData()
    }

}
