//
//  QrViewController.swift
//  doctor
//
//  Created by User on 01.01.2022.
//

import UIKit

class QrViewController: UIViewController {
    var userviewmodelm = userVM()
    @IBOutlet weak var imageview: UIImageView!
    var QrString : String?
    var nom : String?
    var email : String?
    var phone : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nom = userviewmodelm.userToken?.nom
        email = userviewmodelm.userToken?.email
        phone = userviewmodelm.userToken?.phone
        QrString = "name : \(nom!) email: \(email!) phone: \(phone!)."
        imageview.image = generateQRCode(from: QrString!)
        
    }
    

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}
