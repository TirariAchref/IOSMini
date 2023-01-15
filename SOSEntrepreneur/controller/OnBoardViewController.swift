//
//  OnBoardViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
class OnBoardViewController: UIViewController{
 
  

       
    

  
    
    var nom : String?
     var userviewmodelm = userVM()
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var conpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    
    }
    
    @IBAction func register(_ sender: UIButton) {
       
        if(name.text == ""){
            prompt(title: "warning", message: "name is empty")
        }else  if(email.text == ""){
            prompt(title: "warning", message: "email is empty")
        }else  if(password.text == ""){
            prompt(title: "warning", message: "password is empty")
        }else  if(conpassword.text == ""){
            prompt(title: "warning", message: "password is empty")
        }else  if(number.text == ""){
            prompt(title: "warning", message: "number is empty")
        }else{
            if validateEmail(enteredEmail: email.text!) {
                if(password.text == conpassword.text){
                    performSegue(withIdentifier: "register", sender: sender)
                }else{
                    prompt(title: "warning", message: "password don't match")
                }
            }else{
                prompt(title: "warning", message: "email No valide")
            }
           
          
        }
   
      
        
    }
    
 

    @IBAction func sign(_ sender: Any) {
        performSegue(withIdentifier: "signin", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "register" {
            let destination = segue.destination as! confirmationmailViewController
            destination.userviewmodelm = userviewmodelm
            destination.email = email.text
            destination.name = name.text
            destination.password = password.text
            destination.phone = number.text
 
        
            
        }
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
}
