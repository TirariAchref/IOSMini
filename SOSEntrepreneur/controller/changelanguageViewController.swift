//
//  changelanguageViewController.swift
//  doctor
//
//  Created by User on 04.01.2022.
//

import UIKit
import MOLH
class changelanguageViewController: UIViewController {
    var userviewmodelm = userVM()
    var text : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        text = ""
    }
    
       

    @IBAction func engli(_ sender: Any) {
      text = "en"
    }
    
    @IBAction func fr(_ sender: Any) {
        text = "fr"
    }
    @IBAction func update(_ sender: Any) {
        if (text == ""){
            prompt(title: "Warnig", message: "Choose a Language")
        }else {
            MOLH.setLanguageTo(text!)
            MOLH.reset()
           
            performSegue(withIdentifier: "back", sender: sender)
        }
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back" {
            let destination = segue.destination as! tabbarViewController
            destination.userviewmodelm = userviewmodelm
           
        }
    }
    
}
