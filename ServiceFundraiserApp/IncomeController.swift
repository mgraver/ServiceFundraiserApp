//
//  IncomeController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/19/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class IncomeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Variables
    let picker_data = ["Add", "Subtract"]
    @IBOutlet weak var OptionPicker: UIPickerView!
    
    //Set up the view as needed.
    override func viewDidLoad() {
        super.viewDidLoad()
        OptionPicker.delegate = self
        OptionPicker.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
}
