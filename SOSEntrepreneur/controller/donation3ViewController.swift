//
//  donation3ViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class donation3ViewController: UIViewController {

    @IBOutlet var thank: UIView!
    var userviewmodelm = userVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "home"{
            let destination = segue.destination as! tabbarViewController
            destination.userviewmodelm = userviewmodelm
        }
    }
    
    @IBAction func home(_ sender: Any) {
        performSegue(withIdentifier: "home", sender: sender)
    }
    
}
