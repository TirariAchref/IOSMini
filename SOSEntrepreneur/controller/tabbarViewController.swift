//
//  tabbarViewController.swift
//  doctor
//
//  Created by achref on 28/11/2021.
//

import UIKit
import CoreData
class tabbarViewController: UITabBarController {

    var userviewmodelm = userVM()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = self.viewControllers![0] as! UINavigationController
        let vc = navController.topViewController as! homeViewController
        vc.userviewmodelm = userviewmodelm
       
        
        let navController1 = self.viewControllers![2] as! UINavigationController
        let vc1 = navController1.topViewController as! donation1ViewController
        vc1.userviewmodelm = userviewmodelm
       
        
        let navController2 = self.viewControllers![1] as! UINavigationController
        let vc2 = navController2.topViewController as! mailViewController
        vc2.userviewmodelm = userviewmodelm
       
        
        let navController3 = self.viewControllers![3] as! UINavigationController
        let vc3 = navController3.topViewController as! notificationViewController
        vc3.userviewmodelm = userviewmodelm
        let navController4 = self.viewControllers![4] as! senavViewController
        navController4.userviewmodelm = userviewmodelm
        
        let vc4 = navController4.topViewController as! settingViewController
        vc4.userviewmodelm = userviewmodelm
   
      
    }
    
}
