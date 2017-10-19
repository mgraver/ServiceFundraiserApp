//
//  NewRecordController.swift
//  ServiceFundraiserApp
//
//  Created by Michael Graver on 10/17/17.
//  Copyright © 2017 GL. All rights reserved.
//

import UIKit
class NewSessionController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: UIFields
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descrTextView.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descrTextView.resignFirstResponder()
            return true
        }
        return false
    }
}
