//
//  accountconfigViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class accountconfigViewController: UIViewController {
    var userviewmodelm = userVM()
    var user : User?
    @IBOutlet weak var number: UITextField!
    @IBAction func update(_ sender: Any) {
        if(password.text == "" && conpassword.text == ""  ) {
            userviewmodelm.updateuserpass(id: (userviewmodelm.userToken?._id)!, nom: name.text!, prenom: name.text!, email: (userviewmodelm.userToken?.email)!
                                          , phone: number.text!, money: (userviewmodelm.userToken?.money)!)
            prompt(title: "Succes", message: "Updated successfully")
            
        }else{
            if(password.text == conpassword.text) {
                userviewmodelm.updateuser(id: (userviewmodelm.userToken?._id)!, nom: name.text!, prenom: name.text!, email: (userviewmodelm.userToken?.email)!
                                          , password: (password.text)!, phone: number.text!, money: (userviewmodelm.userToken?.money)!)
                prompt(title: "Succes", message: "Updated successfully")
            }else{
                prompt(title: "warning", message: "Password don't match !")
            }
                
        }
           
        
       
        
        
    }
    
    @IBOutlet weak var conpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        name.text = userviewmodelm.userToken?.nom
        number.text = userviewmodelm.userToken?.phone
        
        
    }
    
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
    

  

}
