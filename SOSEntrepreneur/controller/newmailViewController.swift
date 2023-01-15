//
//  newmailViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class newmailViewController: UIViewController {

    var userviewmodelm = userVM()
    var messagerieviewmodel = messagerieVM()
    var bool = false
    var mail : Messagerie?
    @IBOutlet weak var submit: UIButton!
   
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var to: UITextField!

    @IBOutlet weak var message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(bool == true){
            to.text = mail?.from
        }
       
    }
    

    @IBAction func submit(_ sender: Any) {
        if(subject.text == ""){
            prompt(title: "warning", message: "Subject is empty")
        }else  if(to.text == ""){
            prompt(title: "warning", message: "To is empty")
        }else  if(message.text == ""){
            prompt(title: "warning", message: "Message is empty")
        }else {
            messagerieviewmodel.createmessagerie(message: message.text!, object: subject.text!, from: (userviewmodelm.userToken?.email)!, to: to.text!)
            prompt(title: "Succes", message: "Mail added successfully")
        }
       
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

}
