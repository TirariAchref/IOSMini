//
//  securitycodeViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
import AlamofireImage
class securitycodeViewController: UIViewController {
    var randomInt : Int = 0
    var userviewmodel = userVM()
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBAction func `continue`(_ sender: Any) {
        if code.text == String(randomInt){
            performSegue(withIdentifier: "password", sender: sender)
        }else{
            prompt(title: "Error", message: "Code Incorrect !!!")
        }
    }
    
    
    @IBOutlet weak var code: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        username.text = (userviewmodel.userByemail?.nom)!
        //image.image = UIImage(named: (userviewmodel.userByemail?.imageUrl)!)

        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        var path = String("http://localhost:3000/"+(self.userviewmodel.userByemail?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                     path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
        image.af.setImage(withURL: url)
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        randomInt   = Int.random(in: 1000..<9999)
        userviewmodel.sendmail(email: (userviewmodel.userByemail?.email)!, code: String(randomInt))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "password"{
            let destination = segue.destination as! confirmresetpasswordViewController
            destination.userviewmodel = userviewmodel
     
            
        }    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }

}
