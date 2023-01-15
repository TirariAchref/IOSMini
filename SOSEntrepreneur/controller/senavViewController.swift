//
//  senavViewController.swift
//  doctor
//
//  Created by User on 04.01.2022.
//

import UIKit

class senavViewController: UINavigationController {
    var userviewmodelm = userVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc4 = self.topViewController as! settingViewController
        vc4.userviewmodelm = userviewmodelm
    }
    


}
