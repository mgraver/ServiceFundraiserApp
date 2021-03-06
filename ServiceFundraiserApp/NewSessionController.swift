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
    let titlePlaceHolder = "Enter Title Here"
    let descPlaceHolder = "Enter your description here."
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    //MARK:UIFields
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descrTextView.delegate = self
        titleTextField.textColor = UIColor.darkGray
        descrTextView.textColor = UIColor.darkGray
        descrTextView.layer.borderWidth = 2
        descrTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    //MARK:Text field functions
    @IBAction func removePlaceHolder(_ sender: UITextField) {
        if sender.textColor == UIColor.darkGray {
            sender.text = nil
            sender.textColor = UIColor.black
        }
    }
    
    @IBAction func checkEmpty(_ sender: UITextField) {
        if sender.text!.trimmingCharacters(in: .whitespaces).count == 0 {
            sender.textColor = UIColor.darkGray
            sender.text = titlePlaceHolder
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
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text!.trimmingCharacters(in: .whitespaces).count == 0{
            textView.textColor = UIColor.darkGray
            textView.text = descPlaceHolder
        }
    }
    
    //Check to make sure title was entered.
    func validateTitle() -> Bool{
        if titleTextField.text == titlePlaceHolder {
            return false
        }
        return true
    }
    
    func buildSession() -> Session {
        var description:String = "N/A"
        if descrTextView.text != descPlaceHolder{
            description = descrTextView.text
        }
        let newSession = Session(SessionTitle: titleTextField.text!, Description: description)
        return newSession
    }
    
    
    @IBAction func onCreateClick(_ sender: UIButton) {
        if validateTitle() {
            self.performSegue(withIdentifier: "NStoSessionView", sender: self)
        }
    }
    
    @IBAction func onHelpClick(_ sender: UIButton) {
        performSegue(withIdentifier: "NStoH", sender: self)
    }
    
    
    //Send data to the Income controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newSession = buildSession()
        if segue.identifier == "NStoH" {
            let helpView = segue.destination
            slideInTransitioningDelegate.direction = .right
            helpView.transitioningDelegate = slideInTransitioningDelegate
            helpView.modalPresentationStyle = .custom
        } else {
            if let sessionView = segue.destination as? SessionView {
                if segue.identifier == "NStoSessionView"{
                    Singleton.sharedInstance.sessions.append(newSession)
                    Singleton.sharedInstance.sessions.sort(by: sessionSorter)
                    sessionView.currentSession = newSession
                }
            }
        }
    }
    
    // Sorts the session list alphabetically - called everytime a new session is added
    func sessionSorter(this: Session, that: Session) -> Bool {
        return this.name < that.name
    }
    
}
