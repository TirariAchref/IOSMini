//
//  quesViewController.swift
//  doctor
//
//  Created by User on 01.01.2022.
//

import UIKit
import Cosmos
import TinyConstraints
class quesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var userviewmodelm = userVM()
    var questionviewmodel = questionVM()
    var question : Question?
    var usertable : User?
    var filteredData = [Question]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return filteredData.count//6 elements
       }
       
       
       
       
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           tableView.backgroundColor = UIColor(hex: 0xE6FAF0)
           let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
           let contentView = cell?.contentView
           
           let label = contentView?.viewWithTag(1) as! UILabel
           let text = contentView?.viewWithTag(3) as! UILabel
           let imageView = contentView?.viewWithTag(2) as! UIImageView
           
           imageView.layer.masksToBounds = false
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.cornerRadius = imageView.frame.height/2
           imageView.clipsToBounds = true
           label.text = filteredData[indexPath.row].subject
           text.text = filteredData[indexPath.row].description
           userviewmodelm.getOwnerToy(OwnerId: (filteredData[indexPath.row].idClient)! , successHandler: {anomalyList in
               self.usertable = anomalyList
               print("alamofire :")
               print(self.usertable!)
               var path = String("http://localhost:3000/"+(self.usertable?.imageUrl)!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               path = path.replacingOccurrences(of: "%5C", with: "/", options: NSString.CompareOptions.literal, range: nil)
                      let url = URL(string: path)!
                      print(url)
               imageView.af.setImage(withURL: url)
                   }, errorHandler: {
                       print("errorororoor")
                   })
           
           
           
           return cell!
           
       }
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "reponsepass"{
               let destination = segue.destination as! listreponseViewController
               destination.userviewmodelm = userviewmodelm
               destination.question = question
           }
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
           return
       }

    @IBOutlet weak var reponse: UIButton!
    lazy var cosmosView : CosmosView = {
            var view = CosmosView()
            //maadch aandk l hak t modifi
            //view.settings.updateOnTouch = false
            view.settings.fillMode = .half
            view.settings.starMargin = 4
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData.append(question!)
       
     
    }
    

   
    @IBAction func reponsebutton(_ sender: Any) {
        performSegue(withIdentifier: "reponsepass", sender: sender)
    }
    
    @IBAction func rateme(_ sender: Any) {
        prompt(title: "Rate me", message: "")
    }
    func prompt(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
        var n1 = Double((question?.nbrrate)!)
        var n2 = Double((question?.nbruser)!)
           alert.addAction(action)
        alert.view.addSubview(cosmosView)
        cosmosView.centerInSuperview()
        if(n2 == 0){
            
        }else{
            cosmosView.rating = n1! / n2!
        }
       
                cosmosView.didTouchCosmos = {rating in
                    print("Rated: \(rating)")
                  
                    n1 = n1! + rating
                    n2 = n2! + 1
                    self.questionviewmodel.updatequestion(id: (self.question?._id)!, nbrrate: String(n1!), nbruser: String(n2!))
                    self.cosmosView.rating = n1! / n2!
                }
           self.present(alert, animated: true, completion: nil)
           
       }
}
