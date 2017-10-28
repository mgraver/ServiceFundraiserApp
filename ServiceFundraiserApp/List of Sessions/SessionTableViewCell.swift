//
//  SessionTableViewCell.swift
//  ServiceFundraiserApp
//
//  Created by Nathan Lamb on 10/27/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit

@objc(SessionTableViewCell) class SessionTableViewCell: UITableViewCell {

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
