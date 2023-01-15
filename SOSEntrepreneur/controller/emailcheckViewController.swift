//
//  emailcheckViewController.swift
//  doctor
//
//  Created by User on 03.01.2022.
//

import UIKit

class emailcheckViewController: UIViewController {

    @IBOutlet weak var emailtext: UILabel!
    @IBOutlet weak var textfiel: UITextView!
    var userviewmodelm = userVM()
    var mail : Messagerie?
    override func viewDidLoad() {
        super.viewDidLoad()

        emailtext.text = mail?.from
        textfiel.text = mail?.message
    }
    

    @IBAction func submit(_ sender: Any) {
        performSegue(withIdentifier: "repondre", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "repondre"{
            let destination = segue.destination as! newmailViewController
            destination.userviewmodelm = userviewmodelm
            destination.mail = mail
            destination.bool = true
        }
    }
}
