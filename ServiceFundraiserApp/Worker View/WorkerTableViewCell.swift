//
//  WorkerTableViewCell.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 12/4/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

@objc(WorkerTableViewCell) class WorkerTableViewCell: UITableViewCell
{
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hoursWorkedLabel: UILabel!
    @IBOutlet var incomeContributedLabel: UILabel!
    @IBOutlet var editButton: UIButton!
}

/*@objc(SessionTableViewCell) class SessionTableViewCell: UITableViewCell {
    
    @IBOutlet var projectName: UILabel!
    @IBOutlet var projectInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
*/
