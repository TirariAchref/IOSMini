//
//  settingViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import MOLH
class settingViewController: UIViewController{
    var userviewmodelm = userVM()

    @IBOutlet weak var grandimage: UIImageView!
 
    
    
    
    @IBAction func deconnixion(_ sender: Any) {
        print(userviewmodelm.isAuthenticated)
        userviewmodelm.signout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        grandimage.layer.borderWidth = 1
        grandimage.layer.masksToBounds = false
        grandimage.layer.borderColor = UIColor.black.cgColor
        grandimage.layer.cornerRadius = grandimage.frame.height/2
        grandimage.clipsToBounds = true
        // Do any additional setup after loading the view.
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
        grandimage.af.setImage(withURL: url)
           }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "config"{
            let destination = segue.destination as! accountconfigViewController
            destination.userviewmodelm = userviewmodelm
     
            
        }else    if segue.identifier == "QR"{
            let destination = segue.destination as! QrViewController
            destination.userviewmodelm = userviewmodelm
     
            
        }
        else    if segue.identifier == "photo"{
            let destination = segue.destination as! chnagephotoViewController
            destination.userviewmodelm = userviewmodelm
     
            
        }  else    if segue.identifier == "language"{
            let destination = segue.destination as! changelanguageViewController
            destination.userviewmodelm = userviewmodelm
     
            
        }
    }
    
    // action
    
    @IBAction func lanbu(_ sender: Any) {
        performSegue(withIdentifier: "language", sender: sender)
    }
    @IBAction func qrcode(_ sender: Any) {
        performSegue(withIdentifier: "QR", sender: sender)
    }
    @IBAction func deconnexion(_ sender: Any) {
        performSegue(withIdentifier: "deconnexion", sender: sender)
    }
    
    @IBAction func changephoto(_ sender: Any) {
        performSegue(withIdentifier: "photo", sender: sender)
    }
    
    
    @IBAction func config(_ sender: Any) {
        performSegue(withIdentifier: "config", sender: sender)
    }
    
    
    
  
}
