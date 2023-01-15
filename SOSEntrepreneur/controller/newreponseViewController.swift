//
//  newreponseViewController.swift
//  doctor
//
//  Created by User on 03.01.2022.
//

import UIKit

class newreponseViewController: UIViewController {
    //var
    var userviewmodelm = userVM()
    var reponseviewmodel = reponseVM()
    var question : Question?
//outlet
    @IBOutlet weak var textfiel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //action
    
    @IBAction func submit(_ sender: Any) {
        if(textfiel.text == ""){
           prompt(title: "warning", message: "Reponse is empty")
       }else {
           reponseviewmodel.createreponse(description: textfiel.text, idUser: (userviewmodelm.userToken?._id)!, idQuestion: (question?._id)!)
           prompt(title: "Succes", message: "Question added successfully")
       }
    }
    
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    
}
