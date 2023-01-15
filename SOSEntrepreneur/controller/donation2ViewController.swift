//
//  donation2ViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit
import Braintree

// compte samir paypal busines
//
// sb-ei8lh10803981@business.example.com
// password
// s/X3N[<)

// tokenation key
// sandbox_7b2b5hqj_dtg5qdn6p39c3q9b
// secret key
// EMj4nd8l4Vg6EpuB_vFsUq4_cnbtepruwxp8pEErqbgSuHLti0yWe-1kcE_7kgKYA-n8YVqHnBPY6jC2
// sandbox account
// sb-ei8lh10803981@business.example.com
// client id
// AVG0bmX-MM640bmZMTiy22lP2C2h7UxTI1BIq5CV6jccbsBBi3dXHQkUgKSKCfip1Nr2XA5UyopzKU6U
class donation2ViewController: UIViewController {
    var userviewmodelm = userVM()
    
    var user: User?
        var braintreeClient: BTAPIClient!
        var amount = "10"
    @IBOutlet weak var money: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
             braintreeClient = BTAPIClient(authorization: "sandbox_gpgsv2y8_twyv2x893jbftsnw")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pass"{
            let destination = segue.destination as! donation3ViewController
            destination.userviewmodelm = userviewmodelm
        }
    }
    @IBAction func donate(_ sender: Any) {
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
              payPalDriver.viewControllerPresentingDelegate = self
              payPalDriver.appSwitchDelegate = self // Optional
              
              // Specify the transaction amount here. "2.32" is used in this example.
              let request = BTPayPalRequest(amount: amount)
              request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
              
              payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                  if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                      print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                      
                      // Access additional information
                      
                      let email = tokenizedPayPalAccount.email
                      
                      /*let firstName = tokenizedPayPalAccount.firstName
                       let lastName = tokenizedPayPalAccount.lastName
                       let phone = tokenizedPayPalAccount.phone
                       See BTPostalAddress.h for details
                       let billingAddress = tokenizedPayPalAccount.billingAddress
                       let shippingAddress = tokenizedPayPalAccount.shippingAddress*/
                      
                      
                      let message =
                      "You have successfuly paid "
                      + (self.money.text)!
                      + " USD using the paypal account : "
                      + email!
                      
                      self.present(Alert.makeActionAlert(titre: "Success", message:  message, action: UIAlertAction(title: "Proceed", style: .default, handler: { action in
                          self.performSegue(withIdentifier: "pass", sender: sender)
                          let x =  Int((self.userviewmodelm.userToken?.money)!)! + Int((self.money.text)!)!
                          self.userviewmodelm.updateuserpass(id: (self.userviewmodelm.userToken?._id)!, nom:  (self.userviewmodelm.userToken?.nom)!, prenom:  (self.userviewmodelm.userToken?.prenom)!, email: (self.userviewmodelm.userToken?.email)!
                                                        , phone:  (self.userviewmodelm.userToken?.phone)!, money: String(x))
                          
                          self.userviewmodelm.userToken?.money = String(x)
                         
                          
                     
                      })),animated: true)
                      
                     
                  } else if let error = error {
                      print(error)
                  } else {
                      // Buyer canceled payment approval
                  }
              }
              
          
    }

}
extension donation2ViewController : BTViewControllerPresentingDelegate{
       func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
           
       }
       
       func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
           
       }
       
       
   }

   extension donation2ViewController : BTAppSwitchDelegate{
       func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
           
       }
       
       func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
           
       }
       
       func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
           
       }
       
       
   }
