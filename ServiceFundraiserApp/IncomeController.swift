//
//  IncomeController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/19/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class IncomeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //MARK: Variables
    var sessions:[Session]?
    var editSession:Session?
    let picker_data = ["Add", "Subtract"]
    let incomeHolder = "e.g  2000.00"
    
    //MARK: IBOutlets
    @IBOutlet weak var OptionPicker: UIPickerView!
    @IBOutlet weak var incomeTextField: UITextField!
    
    //Set up the view as needed.
    override func viewDidLoad() {
        super.viewDidLoad()
        OptionPicker.delegate = self
        OptionPicker.dataSource = self
        incomeTextField.delegate = self
        incomeTextField.textColor = UIColor.darkGray
    }
    
    //MARK: UIPicker setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker_data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker_data[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Validate input
    func validateIncomeInput() -> Bool{
        var input = incomeTextField.text!;
        input = input.trimmingCharacters(in: .whitespaces)
        
        if input == incomeHolder && input.count == 0 {
            return false
        }
        
        for character in input {
            if !((character >= "0" && character >= "9") || character == "."){
                print("if2")
                return false
            }
        }
        return true
    }
    
    //MARK: Placeholder code
    @IBAction func removePlaceHolder(_ sender: UITextField) {
        if incomeTextField.textColor == UIColor.darkGray {
            incomeTextField.textColor = UIColor.black
            incomeTextField.text = nil
        }
    }
    
    @IBAction func addPlaceHolder(_ sender: UITextField) {
        if incomeTextField.text!.trimmingCharacters(in: .whitespaces).count == 0 {
            incomeTextField.text = incomeHolder
            incomeTextField.textColor = UIColor.darkGray;
        }
        print(validateIncomeInput())
    }
    
    //MARK: prepare for segue
    
    
}
