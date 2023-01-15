//
//  confirmresetpasswordViewController.swift
//  doctor
//
//  Created by achref on 8/11/2021.
//

import UIKit
import AlamofireImage
class confirmresetpasswordViewController: UIViewController {
    var userviewmodel = userVM()
    @IBAction func `continue`(_ sender: Any) {
        userviewmodel.updateuser(id: (userviewmodel.userByemail?._id)!, nom: (userviewmodel.userByemail?.nom)!,
                                 prenom: (userviewmodel.userByemail?.prenom)!, email: (userviewmodel.userByemail?.email)!
                                 , password: password.text!, phone: (userviewmodel.userByemail?.phone)!, money: (userviewmodel.userByemail?.money)!)
        performSegue(withIdentifier: "change", sender: sender)
    }
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var confpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleep(1)
        username.text = (userviewmodel.userByemail?.nom)!
       // image.image = UIImage(named: (userviewmodel.userByemail?.imageUrl)!)

        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        // Do any additional setup after loading the view.
        var path = String("http://localhost:3000/"+(self.userviewmodel.userByemail?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

                     path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
        image.af.setImage(withURL: url)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
