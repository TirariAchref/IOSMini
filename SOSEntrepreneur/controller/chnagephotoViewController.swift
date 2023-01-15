//
//  chnagephotoViewController.swift
//  doctor
//
//  Created by achref on 9/11/2021.
//

import UIKit

class chnagephotoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var userviewmodelm = userVM()
    @IBOutlet weak var grandimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        
        grandimage.layer.borderWidth = 1
        grandimage.layer.masksToBounds = false
        grandimage.layer.borderColor = UIColor.black.cgColor
        grandimage.layer.cornerRadius = grandimage.frame.height/2
        grandimage.clipsToBounds = true
        var path = String("http://localhost:3000/"+(self.userviewmodelm.userToken?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

              path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
               let url = URL(string: path)!
               print(url)
        grandimage.af.setImage(withURL: url)
    }
    
    
 
    @IBAction func dophoto(_ sender: Any) {
        showActionSheet()
        
    }
    
    @IBAction func update(_ sender: Any) {
        self.userviewmodelm.updateToys(Image: self.grandimage.image!, toy: userviewmodelm.userToken, successHandler: {toy in
                        self.prompt(title: "success", message: "updated successfully !")
                    }, errorHandler: {
                        self.prompt(title: "warning", message: "not updated  !")
                    })
    }
    
    func camera()
            {
                let myPickerControllerCamera = UIImagePickerController()
                myPickerControllerCamera.delegate = self
                myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
                myPickerControllerCamera.allowsEditing = true
                self.present(myPickerControllerCamera, animated: true, completion: nil)

            }
      
      
          func gallery()
          {

              let myPickerControllerGallery = UIImagePickerController()
              myPickerControllerGallery.delegate = self
              myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
              myPickerControllerGallery.allowsEditing = true
              self.present(myPickerControllerGallery, animated: true, completion: nil)

          }
      
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              
              guard let selectedImage = info[.originalImage] as? UIImage else {
                 
                  return
             }
              
              self.grandimage.image = selectedImage
              
              
              self.dismiss(animated: true, completion: nil)
          }
      
      
          func showActionSheet(){

              let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
              actionSheetController.view.tintColor = UIColor.black
              let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
                  print("Cancel")
              }
              actionSheetController.addAction(cancelActionButton)

              let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
              { action -> Void in
                  self.camera()
              }
              actionSheetController.addAction(saveActionButton)

              let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
              { action -> Void in
                  self.gallery()
              }
              
              actionSheetController.addAction(deleteActionButton)
              self.present(actionSheetController, animated: true, completion: nil)
          }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
           
           alert.addAction(action)
           self.present(alert, animated: true, completion: nil)
           
       }
}
