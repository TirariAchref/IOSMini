//
//  newquestionViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class newquestionViewController: UIViewController {

    var userviewmodelm = userVM()
    var questionviewmodel = questionVM()

    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var subject: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if(subject.text == ""){
            prompt(title: "warning", message: "Subject is empty")
        }else  if(question.text == ""){
            prompt(title: "warning", message: "Question is empty")
        }else {
            questionviewmodel.createquestion(description: question.text!, subject: subject.text!, idClient: (userviewmodelm.userToken?._id)!)
            let x =  Int((self.userviewmodelm.userToken?.money)!)! - 10
            self.userviewmodelm.updateuserpass(id: (self.userviewmodelm.userToken?._id)!, nom:  (self.userviewmodelm.userToken?.nom)!, prenom:  (self.userviewmodelm.userToken?.prenom)!, email: (self.userviewmodelm.userToken?.email)!
                                          , phone:  (self.userviewmodelm.userToken?.phone)!, money: String(x))
            
            self.userviewmodelm.userToken?.money = String(x)
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
        
        if segue.identifier == "back"{
            let destination = segue.destination as! tabbarViewController
            destination.userviewmodelm = userviewmodelm
        }
    }
 
}
