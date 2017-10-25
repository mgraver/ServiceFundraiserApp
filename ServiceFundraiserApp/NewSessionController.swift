//
//  NewRecordController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/17/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class NewSessionController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK:passed data
    var sessions:[Session]?
    
    //MARK:UIFields
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descrTextView.delegate = self
        titleTextField.textColor = UIColor.darkGray
        descrTextView.textColor = UIColor.darkGray
    }
    
    
    //MARK:Text field functions
    @IBAction func removePlaceHolder(_ sender: UITextField) {
        if sender.textColor == UIColor.darkGray {
            sender.text = nil
            sender.textColor = UIColor.black
        }
    }
    
    @IBAction func checkEmpty(_ sender: UITextField) {
        if sender.text!.count == 0 {
            sender.textColor = UIColor.darkGray
            sender.text = "Enter Title Here"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true;
    }
    
    //MARK:Text view functions
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descrTextView.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    //Check to make sure title was entered.
    func validateTitle() -> Bool{
        return true;
    }
    
    //MARK: actions
    @IBAction func onCreateClick(_ sender: UIButton) {
        print("The length is: \(titleTextField.text!.count)")
    }
    
}
