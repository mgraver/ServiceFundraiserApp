//
//  ListOfSessionsViewController.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/27/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

class ListOfSessionsViewController: UIViewController, TableViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    var tableView: SessionTableViewController!
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "table"
        {
            tableView = segue.destination as! SessionTableViewController
            tableView.delegate = self
            tableView.fillTable(query: "")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        tableView.fillTable(query: searchText)
    }
    
    func didSelectItem(name: String, description: String)
    {
        // Doesn't do anything... but needs to be here or it breaks
    }
    
}
