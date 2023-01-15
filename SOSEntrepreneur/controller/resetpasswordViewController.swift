//
//  resetpasswordViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
import AlamofireImage
class resetpasswordViewController: UIViewController {
    var userviewmodel = userVM()
    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageacchount: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        username.text = (userviewmodel.userByemail?.nom)!
      //  imageacchount.image = UIImage(named: (userviewmodel.userByemail?.imageUrl)!)

        imageacchount.layer.borderWidth = 1
        imageacchount.layer.masksToBounds = false
        imageacchount.layer.borderColor = UIColor.black.cgColor
        imageacchount.layer.cornerRadius = imageacchount.frame.height/2
        imageacchount.clipsToBounds = true
        // Do any additional setup after loading the view.
       
            var path = String("http://localhost:3000/"+(self.userviewmodel.userByemail?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                         path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                          let url = URL(string: path)!
                          print(url)
            imageacchount.af.setImage(withURL: url)
        
     
    }
    @IBAction func send(_ sender: Any) {
        performSegue(withIdentifier: "password", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "password"{
            let destination = segue.destination as! securitycodeViewController
            destination.userviewmodel = userviewmodel
     
            
        }    }

}
